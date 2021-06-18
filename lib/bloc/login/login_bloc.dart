
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/login/login_event.dart';
import 'package:mamo_app/bloc/login/login_state.dart';
import 'package:mamo_app/model/login_data.dart';
import 'package:mamo_app/utils/app_utils.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'package:mamo_app/widget/global_cache.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  UserRepository _userRepository;
  LoginBloc(UserRepository userRepository): _userRepository =userRepository,
  super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginSubmittedEvent){
      yield* _mapLogInSUbmitedToState(event);
    }else if(event is LogOutSubmittedEvent){
      yield await _mapLogOutSubmittedToState();
    }
  }

  Stream<LoginState> _mapLogInSUbmitedToState(LoginSubmittedEvent event) async*{
    yield state.updateWith(status: AppConstants.STATUS_LOADING);
    JDIResponse jdiResponse = await _userRepository.userLogin(
      userName: event.userName, password: event.password
    );
    if(jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS){
      List<LoginData> result =
          jdiResponse.data.map((e) => LoginData.fromJson(e)).toList();
      GlobalCache().setData(result.first);
      await AppUtils.sharedF();
      AppUtils.sharedPreferences.
    setString(AppConstants.HIVE_MEMBER_DATA, jsonEncode(result.first));
      yield state.updateWith(
        loginData: result.length == 0 ? [] : result.first,
            status: AppConstants.STATUS_SUCCESS);
    }else{
      yield state.updateWith(
        status: AppConstants.STATUS_FAILURE,
        err: jdiResponse.errorMessage?? jdiResponse.errorCode
      );
    }
  }
  Future<LoginState> _mapLogOutSubmittedToState() async{
    JDIResponse jdiResponse = await _userRepository.userLogOut();
    if(jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS){
      GlobalCache().clearData();
      return state.updateWith(status: AppConstants.STATUS_SUCCESS);
    }else{
      return state.updateWith(
        status: AppConstants.STATUS_FAILURE,
        err: jdiResponse.errorMessage?? jdiResponse.errorCode
      );
    }
  }
}