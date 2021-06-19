
import 'package:equatable/equatable.dart';

class UpdateProfileEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateProfileSubmitedEvent extends UpdateProfileEvent{
  final String fullName;
  final String address;
  final String gender;
  final String birthdayStr;
  final String email;
  final String momoMobile;
 final String momoName;

  UpdateProfileSubmitedEvent({this.fullName, this.address, this.gender, this.birthdayStr, this.email, this.momoMobile, this.momoName});
  @override
  // TODO: implement props
  List<Object> get props => [fullName, address, gender, birthdayStr, email, momoMobile, momoName];
}