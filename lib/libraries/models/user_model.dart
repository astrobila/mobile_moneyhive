import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/diox.dart';
import 'package:moneyhive/libraries/session.dart';

class User {
  int? id;
  String? username;
  String? email;

  User({
    this.id,
    this.username,
    this.email,
  });

  Map<String, dynamic>  toMap() {

  };
}

class UserModel {
  static const _profileURL = '${AppConfig.baseURL}/api.user.php';
}
