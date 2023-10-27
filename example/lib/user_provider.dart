import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  /// Mimics a user that is logged in.
  User get user => User('John Doe');
}

class User {
  const User(this.name);
  final String name;
}
