import 'dart:convert';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/model/login_data.dart';
import 'package:mamo_app/utils/app_utils.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'package:mamo_app/widget/global_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationStateInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationEventStarted) {
      yield await _mapAuthenticationStartedToState();
    } else if (event is AuthenticationEventLoggedIn) {
      yield AuthenticationStateSuccess(loginData: null);
    } else if (event is AuthenticationEventLoggedOut) {
      yield AuthenticationStateFailure();
    }
  }

  Future<AuthenticationState> _mapAuthenticationStartedToState() async {
    String data;
    await AppUtils.sharedF();
    data = AppUtils.sharedPreferences.getString(AppConstants.HIVE_MEMBER_DATA);

    if (data == null) {
      return AuthenticationStateFailure();
    } else {
      GlobalCache().setData(LoginData.fromJson(jsonDecode(data)));
      return AuthenticationStateSuccess(
        loginData: LoginData.fromJson(
          jsonDecode(data),
        ),
      );
    }
  }
}
