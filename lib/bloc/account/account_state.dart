
import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/login_data.dart';
import 'package:mamo_app/model/user_profile.dart';
import 'package:mamo_app/widget/app_constant.dart';

class AccountState extends Equatable{
  final String err;
  final Account account;
  final int status;

  AccountState({this.err, this.account, this.status = AppConstants.STATUS_INITIAL});

  AccountState updateWith({String err, Account account, int status}){
    return AccountState(
      err: err ?? this.err,
      status: status ?? this.status,
      account: account?? this.account
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [err, status, account];
}