
import 'package:mamo_app/api/api_constants.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/api_service.dart';

class TaskRepository {
  Future<JDIResponse> requestTask({num type}) async {
    ApiResponse apiResponse =
        await ApiService(ApiConstants.GET_TASK, {"Type": type}).getResponse();
    return apiResponse.data;
  }
}
