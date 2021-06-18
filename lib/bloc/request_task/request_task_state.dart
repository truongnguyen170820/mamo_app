
import 'package:equatable/equatable.dart';
import 'package:mamo_app/model/request_task.dart';

class RequestTaskState extends Equatable{
  final String err;
  final RequestTask requestTask;
  final int status;

  RequestTaskState({this.err, this.requestTask, this.status});

  RequestTaskState updateWith({String err, RequestTask requestTask, int status}){
    return RequestTaskState(
      err: err ?? this.err,
      status: status ?? this.status,
      requestTask: requestTask ?? this.requestTask
    );
  }
  @override
  // TODO: implement props
  List<Object> get props => [err, status, requestTask];
}