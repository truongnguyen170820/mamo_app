

import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/home_statitics.dart';
import 'package:mamo_app/widget/app_constant.dart';

class HomeState extends Equatable{
  final String err;
  final HomeStatitics homeStatitics;
  final int status;

  HomeState({this.err, this.homeStatitics, this.status = AppConstants.STATUS_INITIAL});

  HomeState updateWith({String err, HomeStatitics homeStatitics, int status}){
    return HomeState(
      err: err ?? this.err,
      status: status ?? this.status,
    homeStatitics: homeStatitics ?? this.homeStatitics
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [err, status, homeStatitics];

}