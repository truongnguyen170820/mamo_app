

import 'package:mamo_app/model/login_data.dart';

class GlobalCache {
  static GlobalCache _instance;

  factory GlobalCache() => _instance ??= new GlobalCache._();

  GlobalCache._();

  LoginData  loginData;
  String errorMessage;

  LoginData getUser() {
    return loginData;
  }

  void setData(LoginData _data) {
    loginData = _data;
  }

  void clearData() {
    loginData = null;
  }
}
