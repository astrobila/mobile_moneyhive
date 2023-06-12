import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';

class DioX {
  static final DioX _instance = DioX.internal();

  factory DioX() => _instance;

  DioX.internal();

  static Dio? _dio;

  Dio get dio {
    if (_dio != null) {
      return _dio ?? initDio();
    }

    return _dio ?? initDio();
  }

  Dio initDio() {
    Dio dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };

    return dio;
  }
}
