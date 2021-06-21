import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/readers/readers_event.dart';
import 'package:mamo_app/bloc/readers/readers_state.dart';
import 'package:mamo_app/model/recent_reward_reader.dart';
import 'package:mamo_app/widget/app_constant.dart';

class ReadersBloc extends Bloc<ReadersEvent, ReadersState> {
  UserRepository _userRepository;

  ReadersBloc(UserRepository userRepository)
      :assert(userRepository != null),
        _userRepository = userRepository,
        super(ReadersState());

  @override
  Stream<ReadersState> mapEventToState(ReadersEvent event) async* {
    if (event is ReadersStartedEvent) {
      yield state.updateWith(status: AppConstants.STATUS_LOADING);
      JDIResponse jdiResponse = await _userRepository.getRecentReward();
      if (jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS) {
         List<RecentRewardReader> result = jdiResponse.data
            .map((e) => RecentRewardReader.fromJson(e))
            .toList();
        yield state.updateWith(
            status: AppConstants.STATUS_SUCCESS,
            recentRewardReader: result);
      }else{
        yield state.updateWith(
          status: AppConstants.STATUS_FAILURE,
          err: jdiResponse.errorMessage ?? jdiResponse.errorCode
        );
      }
    }
  }
}
