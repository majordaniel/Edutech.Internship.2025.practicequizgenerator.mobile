import 'dart:async';
import 'package:dio/dio.dart' show BaseOptions, Dio, DioException;
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
      // headers: {'X-API-Key': api.key},
    );
    final dio = Dio(baseOptions);
    _api = Api._(Uri.parse(baseOptions.baseUrl), apiKey, dio);
    _initialised = true;
    return _api!;
  }

  /// LOGIN: Stores token and refresh token
  Future<User> login(String email, String password) async {
    // TODO: the error/exception handling here is very ugly and I hate it
    // just do something simple like using constants instead of throwing
    try {
      final response = await dio
          .post('/Auth/login', data: {'email': email, 'password': password})
          .timeout(
            loginRequestTimeout,
            onTimeout: () => throw ApiTimeoutError(),
          );

      if (response.statusCode == 200) {
        final r = ApiResponse.fromHttpResponse(response.data);
        if (r == null) {
          throw ApiRequestError('Http error');
        }

        if (r.succeeded) {
          print('response: $r');

          final body = response.data;
          _token = body['token'];
          _refreshToken =
              body['refreshToken']; // if your API returns a refresh token

          // Now try to fetch the user's credentials
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

  Future<User> _fetchUser(String email) async {
    try {
      final getResponse = await dio.get(
        '/User/email',
        queryParameters: {'email': email},
      );

      if (getResponse.statusCode == 200) {
        final r = ApiResponse.fromHttpResponse(getResponse.data);
        if (r == null) {
          throw ApiRequestError('Http error');
        }

        if (r.succeeded) {
          if (r.data! case {
            'id': String id,
            'firstName': String firstName,
            'lastName': String lastName,
          }) {
            final username = '$firstName $lastName';
            return User(username, id);
          }
          throw ApiRequestError(
            'Internal: Response data format not matched: ${r.data}',
          );
        }
      }
      throw ApiRequestError('Unauthorized/User/email: Invalid credentials');
    } on DioException catch (e) {
      throw ApiRequestError('Network error: ${e.message}');
    }
  }
}

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
