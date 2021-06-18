

import 'package:dio/dio.dart';
import 'package:mamo_app/api/api_response.dart';

abstract class DataFetchCall<T> {
  bool shouldFetchFromDB();

  void loadFromDB();

  T parseJson(Response response);

  Future<Response> createApiAsync({CancelToken cancelToken});

  Future<ApiResponse<T>> getResponse({CancelToken cancelToken}) async {
    try {
      Response response = await createApiAsync(cancelToken: cancelToken);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        T responseModel = parseJson(response);
        return ApiResponse.success<T>(responseModel);
      } else if (response.statusCode == 401) {
        T responseModel = JDIResponse.create(
            response.statusCode.toString(), "Phiên đăng nhập hết hạn, vui lòng đăng nhập lại ứng dụng", 0, []) as T;
        return ApiResponse.failed<T>(
            responseModel, Error(response.statusCode, response.statusMessage));
      } else {
        T responseModel = JDIResponse.create(
            response.statusCode.toString(), response.statusMessage, 0, []) as T;
        return ApiResponse.failed<T>(
            responseModel, Error(response.statusCode, response.statusMessage));
      }
    } catch (error) {
      T responseModel =
          JDIResponse.create("500", "Có lỗi xảy ra, vui lòng thử lại", 0, [])
              as T;
      return ApiResponse.failed<T>(responseModel, Error(500, error.toString()));
    }
  }
}
