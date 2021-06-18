
import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/recent_reward_reader.dart';
import 'package:mamo_app/widget/app_constant.dart';

class ReadersState extends Equatable{
  final String err;
  final List<RecentRewardReader> recentRewardReader;
  final int status;

  ReadersState({this.err,
    this.recentRewardReader, this.status  = AppConstants.STATUS_INITIAL});

  ReadersState updateWith({String err,
    List<RecentRewardReader> recentRewardReader, int status}){
    return ReadersState(
      err: err ?? this.err,
      status: status ?? this.status,
      recentRewardReader: recentRewardReader ?? this.recentRewardReader

    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [err, status,recentRewardReader];
}