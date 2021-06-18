
import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/login_data.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateSuccess extends AuthenticationState {
  final LoginData loginData;

  AuthenticationStateSuccess({this.loginData});

  @override
  List<Object> get props => [loginData];

  @override
  String toString() =>
      'AuthenticationSuccess {fullName: ${loginData.fullName ?? ""}}';
}

class AuthenticationStateFailure extends AuthenticationState {}
