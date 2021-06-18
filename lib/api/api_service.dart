import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mamo_app/api/data_fetch_call.dart';
import 'package:mamo_app/api/network_util.dart';

import 'api_constants.dart';
import 'api_response.dart';

class ApiService extends DataFetchCall<JDIResponse> with Header {
  String _path;
  Map<String, dynamic> _request;
  FormData _fromData = FormData.fromMap({});

  ApiService(String path, Map<String, dynamic> request, {FormData formData})
    {
    this._request = request;
    this._path = path;
    this._fromData = formData;
  }

  @override
  bool shouldFetchFromDB() {
    return false;
  }

  @override
  void loadFromDB() {}

  @override
  Future<Response> createApiAsync({CancelToken cancelToken}) {
    print("$_path----- ${jsonEncode(_request).toString()}");
    return networkUtil.post(ApiConstants.BASE_URL + _path,
        mapData: _request, headers: getHeader(),cancelToken: cancelToken, formData: _fromData);
  }

  @override
  void onSuccess(JDIResponse response) {}

  @override
  JDIResponse parseJson(Response response) {
    return JDIResponse.fromJson(response.data);
  }
}
