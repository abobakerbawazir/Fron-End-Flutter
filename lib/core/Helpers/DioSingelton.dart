import 'package:dio/dio.dart';

class DioSingelton {
  static Dio? _objectDio;
  DioSingelton._singolten();

  static Dio getInstance() {
    if (_objectDio == null) _objectDio = Dio();
    return _objectDio!;
  }
}

class MySingleton {
  static MySingleton? _instance;

  static MySingleton getInstance() {
    if (_instance == null) {
      _instance = new MySingleton();
    }
    return _instance!;
  }

  // ...
}

Dio s=DioSingelton.getInstance();