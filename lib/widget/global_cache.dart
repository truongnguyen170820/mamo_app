

import 'package:mamo_app/model/login_data.dart';

class GlobalCache {
  static GlobalCache _instance;

  factory GlobalCache() => _instance ??= new GlobalCache._();

  GlobalCache._();

  LoginData _loginData;
  String errorMessage;

  LoginData getUser() {
    return _loginData;
  }

  void setData(LoginData _data) {
    _loginData = _data;
  }

  void clearData() {
    _loginData = null;
  }
}
