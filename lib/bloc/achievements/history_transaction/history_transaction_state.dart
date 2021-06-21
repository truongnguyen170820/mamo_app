import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/transaction_history_model.dart';
import 'package:mamo_app/widget/app_constant.dart';

class HistoryTranscationState extends Equatable {
  final String err;
  final List<TransactionHistoryModel> transactionHistoryModel;
  final int status;

  HistoryTranscationState(
      {this.err,
      this.transactionHistoryModel,
      this.status = AppConstants.STATUS_INITIAL});

  HistoryTranscationState updateWith(
      {final String err,
      final List<TransactionHistoryModel> transactionHistoryModel,
      final int status}) {
    return HistoryTranscationState(
        err: err ?? this.err,
        status: status ?? this.status,
        transactionHistoryModel:
            transactionHistoryModel ?? this.transactionHistoryModel);
  }

  @override
  // TODO: implement props
  List<Object> get props => [err, status, transactionHistoryModel];
}
