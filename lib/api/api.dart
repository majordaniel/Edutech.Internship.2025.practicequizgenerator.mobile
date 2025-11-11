// lib/api/api.dart
import 'dart:async';
import 'package:dio/dio.dart' show BaseOptions, Dio, DioException, Response;
import 'package:quiz_generator/models/course.dart';
import 'package:quiz_generator/models/quiz.dart';
import 'package:quiz_generator/models/user.dart' show User;

bool _initialised = false;
Api? _api;

const loginRequestTimeout = Duration(seconds: 10);

class ApiResponse {
  final int statusCode;
  final bool succeeded;
  final String message;
  final Map<String, dynamic>? data;

  ApiResponse._({
    required this.statusCode,
    required this.succeeded,
    required this.message,
    required this.data,
  });

  @override
  String toString() => {
    'statusCode': statusCode,
    'succeeded': succeeded,
    'message': message,
    'data': data,
  }.toString();

  /// Expect the http response body to be a Map<String, dynamic> with the shape:
  /// { statusCode: int, succeeded: bool, message: String, data: Map<String,dynamic>? }
  static ApiResponse? fromHttpResponse(Map<String, dynamic> httpResponse) {
    if (httpResponse case {
      'statusCode': int statusCode,
      'succeeded': bool succeeded,
      'message': String message,
      'data': Map<String, dynamic>? data,
    }) {
      return ApiResponse._(
        statusCode: statusCode,
        succeeded: succeeded,
        message: message,
        data: data,
      );
    } else {
      return null;
    }
  }
}

class Api {
  final String key;
  final Uri baseUrl;
  String? _token;
  String? _refreshToken;

  final Dio dio;

  Api._(this.baseUrl, this.key, this.dio);

  static Future<Api> init({
    required String baseUrl,
    required String apiKey,
  }) async {
    if (_initialised) return _api!;

    final baseOptions = BaseOptions(
      baseUrl: '$baseUrl/api',
      // Add any common headers here if needed
      // headers: {'X-API-Key': apiKey},
    );
    final dio = Dio(baseOptions);
    _api = Api._(Uri.parse(baseOptions.baseUrl), apiKey, dio);
    _initialised = true;
    return _api!;
  }

  /// LOGIN -> returns a User object (fetches user details after receiving token)
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/Auth/login',
        data: {'email': email, 'password': password},
      );

      // debug: print raw
      print("✅ LOGIN RAW RESPONSE:\n${response.data}");

      if (response.statusCode == 200) {
        final r = ApiResponse.fromHttpResponse(response.data);
        if (r == null) {
          throw ApiRequestError('Http error');
        }

        if (r.succeeded) {
          // The actual tokens are inside r.data map
          _token =
              r.data?['accessToken']?.toString() ??
              r.data?['token']?.toString();
          _refreshToken = r.data?['refreshToken']?.toString();

          // After login, fetch user details
          return _fetchUser(email);
        } else {
          throw ApiLoginError();
        }
      } else {
        throw ApiRequestError('Error ${response.statusCode}: ${response.data}');
      }
    } on DioException catch (err) {
      throw ApiRequestError('Network error: ${err.message}');
    }
  }

  /// Fetch user by email and return a User instance
  Future<User> _fetchUser(String email) async {
    try {
      final getResponse = await dio.get(
        '/User/email',
        queryParameters: {'email': email},
      );

      print("✅ USER DETAILS RAW RESPONSE:\n${getResponse.data}");

      if (getResponse.statusCode == 200) {
        final r = ApiResponse.fromHttpResponse(getResponse.data);
        if (r == null) {
          throw ApiRequestError('Http error');
        }

        if (r.succeeded) {
          final data = r.data ?? {};
          // safe matching: require id + either firstName/lastName or name
          final id = data['id']?.toString() ?? '';
          if (id.isEmpty) {
            throw ApiRequestError('User data missing id');
          }

          return User.fromJson(data);
        }
      }
      throw ApiRequestError('Unauthorized/User/email: Invalid credentials');
    } on DioException catch (e) {
      throw ApiRequestError('Network error: ${e.message}');
    }
  }

  /// Fetch courses for a student. Returns an empty list if courses is null or missing.
  Future<List<Course>> fetchUserCourse(String id) async {
    final response = await _responseOrThrow(
      dio.get('/StudentCourse/$id'),
      'Unauthorized/StudentCourse: Invalid id: $id',
    );

    print("📥 RESPONSE RECEIVED (fetchUserCourse): ${response.data}");

    if (response.succeeded && response.data != null) {
      final data = response.data!;
      final coursesRaw = (data['courses'] as List?) ?? [];
      final parsed = coursesRaw
          .map((maybeCourse) {
            if (maybeCourse case {
              'id': String courseId,
              'title': String courseTitle,
            }) {
              return Course(courseId, title: courseTitle);
            } else {
              // Fallback: handle loosely-typed course objects
              final courseId = maybeCourse['id']?.toString() ?? '';
              final courseTitle =
                  maybeCourse['title']?.toString() ?? 'Untitled';
              return Course(courseId, title: courseTitle);
            }
          })
          .toList(growable: false);
      return parsed;
    }

    // Return empty list instead of throwing to avoid crashes in UI
    return <Course>[];
  }

  /// Fetch questions from question bank for a course
  Future<List<Question>> fetchQuestionsFromBank(String courseId) async {
    final response = await _responseOrThrow(
      dio.get('/QuestionBank/course/id/$courseId'),
      'QuestionsFromBank failed',
    );

    print("✅ QUESTION BANK RAW RESPONSE:\n${response.data}");

    if (response.succeeded && response.data != null) {
      final data = response.data!;
      final numQuestions = (data['totalQuestions'] is int)
          ? data['totalQuestions'] as int
          : (data['totalQuestions']?.toString() ?? '0') == '0'
          ? 0
          : (data['totalQuestions'] as int? ?? 0);
      final questionsRaw = (data['questions'] as List?) ?? [];

      if (questionsRaw.isEmpty) {
        return <Question>[];
      }

      return List<Question>.generate(
        questionsRaw.length < numQuestions ? questionsRaw.length : numQuestions,
        (i) {
          final question = questionsRaw[i];
          if (question is Map<String, dynamic> &&
              question.containsKey('options') &&
              question['options'] != null) {
            final questionId = question['id']?.toString() ?? 'unknown';
            final questionText =
                question['text']?.toString() ??
                question['questionText']?.toString() ??
                'No question text';
            final List opts = question['options'] as List;
            int correctOptionIndex = -1;
            final options = List<String>.generate(opts.length, (j) {
              final opt = opts[j];
              if (opt is Map<String, dynamic>) {
                final bool isCorrect = opt['isCorrect'] == true;
                final String text =
                    opt['optionText']?.toString() ??
                    opt['text']?.toString() ??
                    'Option ${j + 1}';
                if (isCorrect) correctOptionIndex = j;
                return text;
              } else {
                return opt?.toString() ?? 'Option ${j + 1}';
              }
            });

            if (correctOptionIndex == -1) {
              // try to use provided correctAnswer if present and is a letter/label
              final maybeLabel = question['correctAnswer'];
              if (maybeLabel != null) {
                // attempt to find option with optionLabel == maybeLabel
                for (var k = 0; k < opts.length; k++) {
                  final opt = opts[k];
                  if (opt is Map &&
                      opt['optionLabel'] != null &&
                      opt['optionLabel'].toString().toLowerCase() ==
                          maybeLabel.toString().toLowerCase()) {
                    correctOptionIndex = k;
                    break;
                  }
                }
              }
            }

            if (correctOptionIndex == -1) {
              // fallback: choose 0 to avoid crash (still log)
              print(
                '⚠️ Warning: correct option not found for questionId=$questionId; defaulting to 0',
              );
              correctOptionIndex = 0;
            }

            return Question(
              questionId,
              question: questionText,
              options: options,
              correctOptionIndex: correctOptionIndex,
            );
          } else {
            // fallback conversion for unexpected shape
            final qid = question['id']?.toString() ?? 'unknown';
            final text =
                question['text']?.toString() ??
                question['questionText']?.toString() ??
                'No question text';
            final optsRaw = (question['options'] as List?) ?? [];
            final opts = optsRaw
                .map(
                  (o) => (o is Map
                      ? (o['optionText'] ?? o['text'] ?? o.toString())
                      : o.toString()),
                )
                .map((e) => e.toString())
                .toList();
            return Question(
              qid,
              question: text,
              options: opts,
              correctOptionIndex: 0,
            );
          }
        },
        growable: false,
      );
    }

    return <Question>[];
  }

  /// Helper that turns Dio Response into ApiResponse or throws errors
  Future<ApiResponse> _responseOrThrow(
    Future<Response> dioFuture,
    String throwMessage,
  ) async {
    try {
      final response = await dioFuture;
      print("📥 RESPONSE RECEIVED: ${response.data}");

      if (response.statusCode == 200) {
        final r = ApiResponse.fromHttpResponse(response.data);
        if (r == null) {
          throw ApiRequestError('Http error');
        }
        return r;
      }
      throw ApiRequestError(throwMessage);
    } on DioException catch (e) {
      throw ApiRequestError('Network error: ${e.message}');
    }
  }
}

/// Specific errors
class ApiLoginError extends ApiRequestError {
  ApiLoginError() : super('Login failed: email or password incorrect');
}

class ApiTimeoutError extends Error {}

class ApiRequestError extends Error {
  final String message;
  ApiRequestError(this.message);
  @override
  String toString() => message;
}
