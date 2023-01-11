import 'dart:convert';

import 'package:coffee_strike/models/result.dart';

class LoginRequest {
  final String? _username;
  final String? _password;

  String? get username => _username;
  String? get password => _password;

  LoginRequest(this._username, this._password);

  String toJson() {
    return json.encode({"username": _username, "password": _password});
  }

}

class LoginSuccess extends ResultSuccess{
  User user;

  LoginSuccess(this.user);
}

class User {
  final String? _id;
  final String? _username;

  String? get id => _id;
  String? get username => _username;

  User(this._id, this._username);

  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _username = json['username'];
}
