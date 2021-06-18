
import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/login_data.dart';
import 'package:mamo_app/widget/app_constant.dart';

class LoginState extends Equatable{
  final String err;
  final LoginData loginData;
  final int status;

  LoginState({this.err = "", this.loginData, this.status = AppConstants.STATUS_INITIAL});

  LoginState updateWith({String err, LoginData loginData, int status}){
    return LoginState(
      err: err?? this.err,
      status: status ?? this.status,
      loginData: loginData ?? this.loginData
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [loginData, status, err];

}