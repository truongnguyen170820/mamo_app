
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/home/home_envet.dart';
import 'package:mamo_app/bloc/home/home_state.dart';
import 'package:mamo_app/model/home_statitics.dart';
import 'package:mamo_app/widget/app_constant.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{

  UserRepository _userRepository;
  HomeBloc(UserRepository userRepository) : _userRepository = userRepository,
  super(HomeState());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is HomeStattedEvent){
      yield* _mapHomeStartedEventToState(event);
    }
  }

  Stream<HomeState> _mapHomeStartedEventToState(
      HomeStattedEvent event
      ) async*{
    yield state.updateWith(
      status:AppConstants.STATUS_LOADING
    );
    JDIResponse jdiResponse = await _userRepository.getHomeStatitics();
    if(jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS){
      List<HomeStatitics> result =jdiResponse.data.map((e) => HomeStatitics.fromJson(e)).toList();

      yield state.updateWith(
        status: AppConstants.STATUS_SUCCESS,
      homeStatitics:result.length == 0 ? [] : result.first
      );
    }else{
      yield state.updateWith(
        status:AppConstants.STATUS_FAILURE,
        err: jdiResponse.errorMessage??jdiResponse.errorCode
      );
    }
  }

}