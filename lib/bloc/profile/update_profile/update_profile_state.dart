
import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/update_profile_request.dart';
import 'package:mamo_app/widget/app_constant.dart';

class UpdateProfileState extends Equatable{
  final String err;
  final UpdateProfileRequest updateProfileRequest;
  final int status;

  UpdateProfileState({this.err, this.updateProfileRequest, this.status = AppConstants.STATUS_INITIAL});

  UpdateProfileState updateWith({String err, UpdateProfileRequest updateProfileRequest, int status}){
    return UpdateProfileState(
      err: err ?? this.err,
      status: status ?? this.status,
      updateProfileRequest: updateProfileRequest ?? this.updateProfileRequest
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [err, status, updateProfileRequest];
}