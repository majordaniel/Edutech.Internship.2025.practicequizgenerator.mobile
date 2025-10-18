import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

// ...and authenticated
bool _initialised = false;
Api? _api;

const loginRequestTimeout = Duration(seconds: 5);

// Unauthenticated API Handle
// It should be a singleton
class Api {
  final String key;
  final Uri baseUrl;

  Api._(this.baseUrl, this.key);

  static Future<Api> init({
    required String baseUrl,
    required String apiKey,
  }) async {
    if (_initialised) return _api!;

    _initialised = true;
    return Api._(Uri.parse('$baseUrl/api'), apiKey);
  }

  Future<bool> login(String studentId, String password) async {
    // TODO: check if network is active before attempting this
    final r = http
        .post(
          Uri.parse('$baseUrl/Auth/login'),
          headers: {'X-API-Key': key},
          body: {'email': studentId, 'password': password},
        )
        .timeout(loginRequestTimeout, onTimeout: () => throw ApiTimeoutError())
        .onError<SocketException>((err, StackTrace stk) {
          print('ApiRequestError: ${err.message}');
          return http.Response(err.message, _apiRequestErrorCode);
        })
        .then((r) {
          // TODO: deal with error message
          if (r.statusCode == _apiRequestErrorCode) {
            throw ApiRequestError(r.body);
          }
          return r.statusCode == 200;
        });

    return r;
  }

  Future<bool> registerUser(RegistrationParameters rparams) async {
    var r = http
        .post(
          Uri.parse('$baseUrl/Auth/login'),
          headers: {'X-API-Key': key},
          body: rparams.toJson(),
        )
        .then((r) {
          // TODO: deal with error message
          return r.statusCode == 200;
        });
    return r;
  }
}

class ApiTimeoutError extends Error {
  ApiTimeoutError();
}

class ApiRequestError extends Error {
  final String message;
  ApiRequestError(this.message);
}

const _apiRequestErrorCode = 744;

typedef RegistraionNumber = int;
typedef LevelCode = String;

class RegistrationParameters {
  final String firstName;
  final String lastName;
  final String otherName;
  final String email;
  final String departmentName;
  final String facultyName;
  final RegistraionNumber registrationNumber;
  final LevelCode currentLevelCode;

  RegistrationParameters({
    required this.firstName,
    required this.lastName,
    required this.otherName,
    required this.email,
    required this.departmentName,
    required this.facultyName,
    required this.registrationNumber,
    required this.currentLevelCode,
  });

  Map<String, String> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'otherName': otherName,
      'email': email,
      'departmentName': departmentName,
      'facultyName': facultyName,
      'registrationNumber': registrationNumber.toString(),
      'currentLevelCode': currentLevelCode,
    };
  }
}
