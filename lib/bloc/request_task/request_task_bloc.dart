
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/services/task_repository.dart';
import 'package:mamo_app/api/services/user_repository.dart';
import 'package:mamo_app/bloc/request_task/request_task_event.dart';
import 'package:mamo_app/bloc/request_task/request_task_state.dart';
import 'package:mamo_app/model/home_statitics.dart';
import 'package:mamo_app/model/request_task.dart';
import 'package:mamo_app/widget/app_constant.dart';

class RequestTaskBloc extends Bloc<RequestTaskEvent, RequestTaskState>{
  TaskRepository _taskRepository;

  RequestTaskBloc(TaskRepository taskRepository)
      : _taskRepository = taskRepository, super(RequestTaskState());

  @override
  Stream<RequestTaskState> mapEventToState(RequestTaskEvent event) async*{

    if(event is RequestStartedEvent){
      yield state.updateWith(
        status: AppConstants.STATUS_LOADING
      );
      JDIResponse jdiResponse = await _taskRepository.requestTask(type: event.type);
      if(jdiResponse.errorCode == AppConstants.ERROR_CODE_SUCCESS){
        List<RequestTask> result = jdiResponse.data.map((e) => RequestTask.fromJson(e)).toList();
        yield state.updateWith(status: AppConstants.STATUS_SUCCESS,
        requestTask: result.length ==0? [] : result.first);
      }else{
        yield state.updateWith(
          status: AppConstants.STATUS_FAILURE,
          err: jdiResponse.errorMessage ?? jdiResponse.errorCode
        );
      }
    }
  }


}