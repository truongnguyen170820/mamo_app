
import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/user_profile.dart';
import 'package:mamo_app/widget/app_constant.dart';

class ProfileState extends Equatable{
  final String err;
  final UserProfile userProfile;
  final int status;

  ProfileState({this.err, this.userProfile, this.status = AppConstants.STATUS_INITIAL});

  ProfileState updateWith({String err, UserProfile userProfile, int status}){
    return ProfileState(
      err: err ?? this.err,
      status: status ?? this.status,
      userProfile: userProfile?? this.userProfile
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [err, status, userProfile];
}