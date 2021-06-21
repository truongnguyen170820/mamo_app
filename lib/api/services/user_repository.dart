import 'package:mamo_app/api/api_constants.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/api/api_service.dart';
import 'package:mamo_app/model/login_request.dart';
import 'package:mamo_app/model/update_profile_request.dart';
import 'package:mamo_app/widget/app_constant.dart';

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

  // Profile
  Future<JDIResponse> getProfile() async {
    ApiResponse apiResponse =
        await ApiService(ApiConstants.GET_PROFILE, {}).getResponse();
    return apiResponse.data;
  }

  // Account
  Future<JDIResponse> getAccount() async {
    ApiResponse apiResponse =
        await ApiService(ApiConstants.GET_ACCOUNT, {}).getResponse();
    return apiResponse.data;
  }

  //UpdateProfile
  Future<JDIResponse> getUpdateProfile(
      String fullName,
      String address,
      String gender,
      String birthDay,
      String email,
      String momoMoblie,
      String momoName) async {
    ApiResponse apiResponse = await ApiService(
            ApiConstants.UPDATE_PROFILE,
            UpdateProfileRequest(
                    fullName: fullName,
                    address: address,
                    gender: gender,
                    birthdayStr: birthDay,
                    email: email,
                    momoMobile: momoMoblie,
                    momoName: momoName)
                .toJson())
        .getResponse();
    return apiResponse.data;
  }

//History Transcation
  Future<JDIResponse> getHistoryTranscation(
      {num type = 3, int pageIndex = 1}) async {
    ApiResponse apiResponse = await ApiService(ApiConstants.TRANSACTION_HIS, {
      "Type": type,
      "PageIndex": pageIndex,
      "PageSize": AppConstants.PAGE_SIZE
    }).getResponse();
    return apiResponse.data;
  }
}
