// lib/models/user.dart
import 'package:flutter/material.dart';
import 'package:quiz_generator/api/api.dart';
import 'package:quiz_generator/models/course.dart';

/// User model
/// NOTE: keeps the original positional constructor so existing call sites don't break:
///   const User('Janet Jane Jones', 'jjj@ccmail.com');
class User {
  final String id;
  final String name;
  final bool loggedIn;

  const User(this.name, this.id, {this.loggedIn = false});

  /// Create from API json shape
  factory User.fromJson(Map<String, dynamic> json) {
    final id = json['id']?.toString() ?? '';
    final firstName = json['firstName'] ?? '';
    final lastName = json['lastName'] ?? '';
    final fullName = '$firstName $lastName'.trim();
    return User(fullName.isEmpty ? (json['name']?.toString() ?? '') : fullName, id, loggedIn: true);
  }

  User copyWith({String? id, String? name, bool? loggedIn}) {
    return User(
      name ?? this.name,
      id ?? this.id,
      loggedIn: loggedIn ?? this.loggedIn,
    );
  }

  @override
  String toString() {
    return 'User<Id="$id", Name="$name", loggedIn=$loggedIn>';
  }
}

/// Controller for user + caching user courses
class UserController with ChangeNotifier {
  User _user;
  User get user => _user;

  List<Course>? _courseList;
  final Api _api;

  UserController(this._user, this._api);

  void update(User user) {
    print('UserController: updated from $_user to $user');
    _user = user;
    notifyListeners();
  }

  /// Return cached courses or fetch from API. Always returns a list (may be empty).
  Future<List<Course>> courses() async {
    if (_courseList == null) {
      try {
        final l = await _api.fetchUserCourse(_user.id);
        _courseList = l;
        print('UserController: fetched courses: $_courseList');
      } catch (e) {
        print('UserController: failed to fetch courses: $e');
        _courseList = [];
      }
    } else {
      print('UserController: fetched cached courses: $_courseList');
    }
    return _courseList!;
  }

  /// Optionally clear cache (useful on logout or switching user)
  void clearCachedCourses() {
    _courseList = null;
  }
}
