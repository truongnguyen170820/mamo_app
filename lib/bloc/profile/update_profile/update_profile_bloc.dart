

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/profile/update_profile/update_profile_event.dart';
import 'package:mamo_app/bloc/profile/update_profile/update_profile_state.dart';
import 'package:mamo_app/model/update_profile_request.dart';
import 'package:mamo_app/widget/app_constant.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState>{

  UserRepository _userRepository;
  UpdateProfileBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(UpdateProfileState());
  @override
  Stream<UpdateProfileState> mapEventToState(UpdateProfileEvent event) async* {
    if (event is UpdateProfileSubmitedEvent) {
      yield* _mapUpdateProfileToState(event);
    }
  }

    Stream<UpdateProfileState> _mapUpdateProfileToState(
        UpdateProfileSubmitedEvent event) async* {
      yield state.updateWith(status: AppConstants.STATUS_LOADING);
      JDIResponse jdiResponse = await _userRepository.getUpdateProfile(
          event.fullName,
          event.address,
          event.gender,
          event.birthdayStr,
          event.email,
          event.momoMobile,
          event.momoName);
      if (jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS) {
        List<UpdateProfileRequest> result =
        jdiResponse.data.map((e) => UpdateProfileRequest.fromJson(e)).toList();
        yield state.updateWith(
            status: AppConstants.STATUS_SUCCESS,
            updateProfileRequest: result.length == 0
                ? UpdateProfileRequest()
                : result.first
        );
        print(state.status);
      } else {
        yield state.updateWith(
            status: AppConstants.STATUS_FAILURE,
            err: jdiResponse.errorMessage ?? jdiResponse.errorCode
        );
      }
    }
  }


