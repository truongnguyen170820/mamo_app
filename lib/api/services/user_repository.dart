import 'package:mamo_app/api/api_constants.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/api_service.dart';
import 'package:mamo_app/model/login_request.dart';

class UserRepository {
  // User Login
  Future<JDIResponse> userLogin({String userName, String password}) async {
    ApiResponse apiResponse = await ApiService(
        ApiConstants.SIGNIN_ACCOUNT,
        LoginRequest(
            appName: "mamo", password: password, userName: userName)
            .toJson())
        .getResponse();
    return apiResponse.data;
  }
  // LogOut
  Future<JDIResponse> userLogOut() async {
    ApiResponse apiResponse =
    await ApiService(ApiConstants.SIGNOUT_ACCOUNT, {}).getResponse();
    return apiResponse.data;
  }

  // Get HomeStatitics
  Future<JDIResponse> getHomeStatitics() async {
    ApiResponse apiResponse =
    await ApiService(ApiConstants.GET_HOME_STATISTIC, {}).getResponse();
    return apiResponse.data;
  }
  //recent reward
  Future<JDIResponse> getRecentReward() async {
    ApiResponse apiResponse =
    await ApiService(ApiConstants.GET_RECENT_REWARDS, {}).getResponse();
    return apiResponse.data;
  }

}