
import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginSubmittedEvent extends LoginEvent{
  final String userName;
  final String password;

  LoginSubmittedEvent({this.userName, this.password});

  @override
  // TODO: implement props
  List<Object> get props => [userName, password];
}
class LogOutSubmittedEvent extends LoginEvent{

}