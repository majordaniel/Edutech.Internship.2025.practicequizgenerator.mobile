import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

bool _initialised = false;
Api? _api;

const loginRequestTimeout = Duration(seconds: 10);

class Api {
  final String key;
  final Uri baseUrl;
  String? _token;
  String? _refreshToken;

  Api._(this.baseUrl, this.key);

  static Future<Api> init({
    required String baseUrl,
    required String apiKey,
  }) async {
    if (_initialised) return _api!;

    _initialised = true;
    _api = Api._(Uri.parse('$baseUrl/api'), apiKey);
    return _api!;
  }

  /// LOGIN: Stores token and refresh token
  Future<void> login(String email, String password) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/Auth/login'),
            headers: {
              'X-API-Key': key,
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(loginRequestTimeout, onTimeout: () => throw ApiTimeoutError());

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        _token = body['token'];
        _refreshToken = body['refreshToken']; // if your API returns a refresh token
      } else if (response.statusCode == 401) {
        throw ApiRequestError('Unauthorized: Invalid credentials');
      } else {
        throw ApiRequestError('Error ${response.statusCode}: ${response.body}');
      }
    } on SocketException catch (err) {
      throw ApiRequestError('Network error: ${err.message}');
    }
  }

  /// REGISTRATION
  Future<bool> registerUser(RegistrationParameters params) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Auth/register'),
        headers: {
          'X-API-Key': key,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) return true;

      throw ApiRequestError('Error ${response.statusCode}: ${response.body}');
    } on SocketException catch (err) {
      throw ApiRequestError('Network error: ${err.message}');
    }
  }

  /// GET request with automatic token refresh
  Future<http.Response> get(String endpoint) async {
    if (_token == null) throw ApiRequestError('Not authenticated. Please login first.');

    try {
      final response = await _makeRequest('GET', endpoint);

      if (response.statusCode == 401 && _refreshToken != null) {
        // Token expired, try refreshing
        await _refreshAuthToken();
        return await _makeRequest('GET', endpoint); // retry
      }

      return response;
    } on SocketException catch (err) {
      throw ApiRequestError('Network error: ${err.message}');
    }
  }

  /// INTERNAL: Makes HTTP request with auth header
  Future<http.Response> _makeRequest(String method, String endpoint) async {
    final headers = {
      'X-API-Key': key,
      'Authorization': 'Bearer $_token',
      'Content-Type': 'application/json',
    };

    switch (method) {
      case 'GET':
        return await http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers);
      default:
        throw ApiRequestError('HTTP method $method not implemented');
    }
  }

  /// INTERNAL: Refresh auth token
  Future<void> _refreshAuthToken() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Auth/refresh-token'),
        headers: {
          'X-API-Key': key,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'refreshToken': _refreshToken}),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        _token = body['token'];
        _refreshToken = body['refreshToken']; // update refresh token if provided
      } else {
        throw ApiRequestError('Unable to refresh token. Please login again.');
      }
    } on SocketException catch (err) {
      throw ApiRequestError('Network error while refreshing token: ${err.message}');
    }
  }
}

class ApiTimeoutError extends Error {}

class ApiRequestError extends Error {
  final String message;
  ApiRequestError(this.message);
}

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

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'otherName': otherName,
      'email': email,
      'departmentName': departmentName,
      'facultyName': facultyName,
      'registrationNumber': registrationNumber,
      'currentLevelCode': currentLevelCode,
    };
  }
}
