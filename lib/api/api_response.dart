

import 'package:mamo_app/widget/global_cache.dart';

class ApiResponse<T> {
  Status status;
  T data;
  Error error;

  ApiResponse(Status status, T data, Error error) {
    this.status = status;
    this.data = data;
    this.error = error;
  }

  static ApiResponse success<ResultType>(ResultType data) {
    return ApiResponse<ResultType>(Status.SUCCESS, data, null);
  }

  static ApiResponse failed<ResultType>(ResultType data, Error error) {
    return ApiResponse<ResultType>(Status.ERROR, data, error);
  }
}

class Error {
  int statusCode;
  String statusMessage;

  Error(this.statusCode, this.statusMessage);
}

enum Status { LOADING, SUCCESS, ERROR }

class JDIResponse {
  final String errorCode;
  final String errorMessage;
  final int total;
  final List<dynamic> data;

  JDIResponse.create(
      String errorCode, String errorMessage, this.total, this.data)
      : errorCode = errorCode,
        errorMessage = errorMessage;

  JDIResponse.fromJson(Map<String, dynamic> json)
      : errorCode = json["ErrorCode"],
        errorMessage = json["ErrorMessage"],
        total = json["Total"],
        data = json["Data"];
}

abstract class Header {
  factory Header._() => null;

  Map<String, String> getHeader() {
    Map<String, String> map = new Map();
    map["AppKey"] = "i4fKAo8kFLQzsMIZKh2ZyzysRkeMye";
    if (GlobalCache().getUser() != null) {
      map["SessionId"] = GlobalCache().getUser().sessionId;
    }

    return map;
  }
}
