import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/profile/profile_event.dart';
import 'package:mamo_app/bloc/profile/profile_state.dart';
import 'package:mamo_app/model/user_profile.dart';
import 'package:mamo_app/widget/app_constant.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository _userRepository;

  ProfileBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(ProfileState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async*{
    if(event is ProfileGetEvent){
      yield* _mapProfileToState();
    }
  }

  Stream<ProfileState> _mapProfileToState() async* {
    yield state.updateWith(status: AppConstants.STATUS_LOADING);
    JDIResponse jdiResponse = await _userRepository.getProfile();
    if (jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS) {
      List<UserProfile> result =
          jdiResponse.data.map((e) => UserProfile.fromJson(e)).toList();
      yield state.updateWith(
          status: AppConstants.STATUS_SUCCESS, userProfile: result.first);
    } else {
      yield state.updateWith(
          status: AppConstants.STATUS_FAILURE,
          err: jdiResponse.errorMessage ?? jdiResponse.errorCode);
    }
  }
}
