import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:moneyhive/app_config.dart';
import 'package:moneyhive/libraries/diox.dart';

class SessionData {
  int status;
  dynamic data;

  SessionData({
    required this.status,
    required this.data,
  });
}

class Session {
  static const String _sessionURL =
      '${AppConfig.baseURL}/api.session.php?action=';
  static const String _loginURL = '${AppConfig.baseURL}/api.login.php';
  static const String _logoutURL = '${AppConfig.baseURL}/api.logout.php';

  Future<String> get sessionId async {
    return await initSession();
  }

  static Future<String> _initSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    String sessid = prefs.getString('sessid') ?? '';

    try {
      var dio = DioX().dio;
      Response response = await dio.get('${_sessionURL}id');
      Map<String, dynamic> map = jsonDecode(response.data.toString());
      sessid = map['id'];
    } on Exception catch (_) {}

    return sessid;
  }

  static Future<String> initSession() async {
    final prefs = await SharedPreferences.getInstance();
    String sessid = prefs.getString('sessid') ?? '';

    if (sessid == '') {
      sessid = await _initSessionId();
      await prefs.setString('sessid', sessid);
    }

    return sessid;
  }

  static Future<void> destroySession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessid', '');
  }

  static Future<SessionData> getSession() async {
    String sessid = await initSession();

    try {
      var dio = DioX().dio;
      Response response = await dio.get(
        '${_sessionURL}status',
        options: Options(
          headers: {
            'Cookie': 'PHPSESSID=$sessid',
          },
        ),
      );
      Map<String, dynamic> map = jsonDecode(response.data.toString());
      map['status'] = map.containsKey('status') ? map['status'] : 0;
      map['data'] = map.containsKey('data') ? map['data'] : '';

      if (map['status'] as int == 0) {
        destroySession();
      }

      return SessionData(
        status: map['status'] as int,
        data: map['data'],
      );
    } on Exception catch (_) {}

    return SessionData(
      status: 0,
      data: {},
    );
  }

  static Future<SessionData> login(String username, String password) async {
    String sessid = await initSession();

    try {
      var dio = DioX().dio;
      Response response = await dio.post(
        _loginURL,
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
        options: Options(
          headers: {
            'Cookie': 'PHPSESSID=$sessid',
          },
        ),
      );
      Map<String, dynamic> map = jsonDecode(response.data.toString());
      map['status'] = map.containsKey('status') ? map['status'] : 0;
      map['data'] = map.containsKey('data') ? map['data'] : {};

      return SessionData(
        status: map['status'] as int,
        data: map['data'],
      );
    } on Exception catch (_) {
      print(_.toString());
    }

    return SessionData(
      status: 0,
      data: {},
    );
  }

  static Future<SessionData> logout() async {
    String sessid = await initSession();

    try {
      var dio = DioX().dio;
      Response response = await dio.get(
        _logoutURL,
        options: Options(
          headers: {
            'Cookie': 'PHPSESSID=$sessid',
          },
        ),
      );
      Map<String, dynamic> map = jsonDecode(response.data.toString());
      map['status'] = map.containsKey('status') ? map['status'] : 0;
      map['data'] = map.containsKey('data') ? map['data'] : {};

      return SessionData(
        status: map['status'] as int,
        data: map['data'],
      );
    } on Exception catch (_) {}

    return SessionData(
      status: 0,
      data: {},
    );
  }

  static Future<SessionData> getURL(String url) async {
    String sessid = await initSession();

    try {
      var dio = DioX().dio;

      Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Cookie': 'PHPSESSID=$sessid',
          },
        ),
      );
      Map<String, dynamic> map = jsonDecode(response.data.toString());
      map['status'] = map.containsKey('status') ? map['status'] : 0;
      map['data'] = map.containsKey('data') ? map['data'] : {};

      return SessionData(
        status: map['status'] as int,
        data: map['data'],
      );
    } on Exception catch (_) {
      print(_.toString());
    }

    return SessionData(
      status: 0,
      data: {},
    );
  }

  static Future<SessionData> postURL(
      String url, Map<String, dynamic> data) async {
    String sessid = await initSession();

    try {
      var dio = DioX().dio;
      Response response = await dio.post(
        url,
        data: FormData.fromMap(data),
        options: Options(
          headers: {
            'Cookie': 'PHPSESSID=$sessid',
          },
        ),
      );
      Map<String, dynamic> map = jsonDecode(response.data.toString());
      map['status'] = map.containsKey('status') ? map['status'] : 0;
      map['data'] = map.containsKey('data') ? map['data'] : {};

      return SessionData(
        status: map['status'] as int,
        data: map['data'],
      );
    } on Exception catch (_) {}

    return SessionData(
      status: 0,
      data: {},
    );
  }
}
