import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationEventStarted extends AuthenticationEvent {}

class AuthenticationEventLoggedIn extends AuthenticationEvent {}

class AuthenticationEventLoggedOut extends AuthenticationEvent {}
