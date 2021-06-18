

import 'package:equatable/equatable.dart';

class RequestTaskEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RequestStartedEvent extends RequestTaskEvent{
final num type;

  RequestStartedEvent({this.type});

  @override
  // TODO: implement props
  List<Object> get props => [type];
}