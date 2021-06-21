
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/achievements/history_transaction/history_transaction_event.dart';
import 'package:mamo_app/bloc/achievements/history_transaction/history_transaction_state.dart';
import 'package:mamo_app/model/transaction_history_model.dart';
import 'package:mamo_app/widget/app_constant.dart';

class HistoryTransactionBloc extends Bloc<HistoryTranscationEvent, HistoryTranscationState>{
  UserRepository _userRepository;
  HistoryTransactionBloc(UserRepository userRepository):
      assert(userRepository != null),
      _userRepository = userRepository,
  super(HistoryTranscationState());

  @override
  Stream<HistoryTranscationState> mapEventToState(HistoryTranscationEvent event)async* {
    if(event is HistoryTranscationStartedEvent){
      yield* _mapHistoryTranscationToState();
    }
  }
  Stream<HistoryTranscationState> _mapHistoryTranscationToState() async*{
    yield state.updateWith(
      status: AppConstants.STATUS_LOADING,
    );
    JDIResponse jdiResponse = await _userRepository.getHistoryTranscation();
    if(jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS){
      List<TransactionHistoryModel> result =
      jdiResponse.data.map((e) =>
          TransactionHistoryModel.fromJson(e)).toList();
      yield state.updateWith(
        status: AppConstants.STATUS_SUCCESS,
        transactionHistoryModel: result.length == 0 ? [] : result
      );
    }else{
      yield state.updateWith(
        status: AppConstants.STATUS_FAILURE,
        err: jdiResponse.errorMessage?? jdiResponse.errorCode
      );
    }
  }
}