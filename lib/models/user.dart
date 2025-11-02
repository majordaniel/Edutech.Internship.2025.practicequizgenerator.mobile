import 'package:flutter/material.dart';
import 'package:quiz_generator/api/api.dart';
import 'package:quiz_generator/models/course.dart';

class User {
  final String id;
  final String name;
  final bool loggedIn = false;

  const User(this.name, this.id);

  @override
  String toString() {
    return 'User<Id="$id", Name="$name", $loggedIn>';
  }
}

class UserController with ChangeNotifier {
  User _user;
  User get user => _user;
  List<Course>? _courseList;
  Api _api;

  UserController(this._user, this._api);

  void update(User user) {
    // TODO: verify the passed user data
    print('UserController: updated from $_user to $user');
    _user = user;
    notifyListeners();
  }

  Future<List<Course>> courses() async {
    if (_courseList == null) {
      final l = await _api.fetchUserCourse(_user.id);
      print('UserController: fetched courses: $l');
      _courseList = l;
    } else {
      print('UserController: fetched cached courses: $_courseList');
    }
    return _courseList!;
  }
}
