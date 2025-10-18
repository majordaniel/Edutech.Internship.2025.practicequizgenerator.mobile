import 'package:flutter/material.dart';

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

  UserController(this._user);

  void update(User user) {
    // TODO: verify the passed user data
    print('UserController: updated from $_user to $user');
    _user = user;
    notifyListeners();
  }
}
