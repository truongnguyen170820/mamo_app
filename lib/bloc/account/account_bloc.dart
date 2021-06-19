import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/account/account_event.dart';
import 'package:mamo_app/bloc/account/account_state.dart';
import 'package:mamo_app/bloc/profile/profile_event.dart';
import 'package:mamo_app/bloc/profile/profile_state.dart';
import 'package:mamo_app/model/login_data.dart';
import 'package:mamo_app/model/user_profile.dart';
import 'package:mamo_app/widget/app_constant.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  UserRepository _userRepository;

  AccountBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(AccountState());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if(event is AccountGetEvent){
      yield* _mapAccountToState();
    }
  }

  Stream<AccountState> _mapAccountToState() async* {
    yield state.updateWith(status: AppConstants.STATUS_LOADING);
    JDIResponse jdiResponse = await _userRepository.getAccount();
    if (jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS) {
      List<Account> result =
          jdiResponse.data.map((e) => Account.fromJson(e)).toList();
      yield state.updateWith(
          status: AppConstants.STATUS_SUCCESS, account: result.first);
    } else {
      yield state.updateWith(
          status: AppConstants.STATUS_FAILURE,
          err: jdiResponse.errorMessage ?? jdiResponse.errorCode);
    }
  }
}
