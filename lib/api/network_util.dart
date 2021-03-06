import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:mamo_app/api/api_response.dart';
import 'package:mamo_app/widget/app_constant.dart';

import 'api_constants.dart';

class NetworkUtil {
  Dio _dio;

  NetworkUtil() {
    ///Create Dio Object using baseOptions set receiveTimeout,connectTimeout
    BaseOptions options =
        BaseOptions(receiveTimeout: 25000, connectTimeout: 25000);
    options.baseUrl = ApiConstants.BASE_URL;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor());
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  ///used for calling Get Request
  Future<Response> get(String url, Map<String, dynamic> params,
      {Map<String, String> headers, CancelToken cancelToken}) async {
    Response response;
    if(cancelToken!=null){
      response = await _dio.get(url,
          queryParameters: params,
          cancelToken: cancelToken,
          options: Options(responseType: ResponseType.json, headers: headers));
    } else
      response = await _dio.get(url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json, headers: headers));
    return response;
  }

  ///used for calling post Request
  Future<Response> post(String url,
      {Map<String, String> headers,
      Map<String, dynamic> mapData,
      FormData formData,
      CancelToken cancelToken}) async {
    try {
      Response response;
      if (mapData != null)
        response = await _dio.post(url,
            data: mapData,
            cancelToken: cancelToken,
            options: Options(
                responseType: ResponseType.json, headers: headers));
      else if (formData != null)
        response = await _dio.post(url,
            data: formData,
            cancelToken: cancelToken,
            options: Options(
                responseType: ResponseType.json, headers: headers));
print(response);
      return response;
    } on DioError catch(e) {
      // print("err: " + e.message);
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        return Response(
            statusCode: 999,
            statusMessage: "L???i timeout, vui l??ng ki???m tra k???t n???i internet v?? th??? l???i!",
            data: JDIResponse.create(AppConstants.JDI_ERROR_TIMEOUT, "L???i timeout, vui l??ng ki???m tra k???t n???i internet v?? th??? l???i!", 0, null)
        );
      } else if (DioErrorType.RESPONSE == e.type) {
        return Response(
            statusCode: 999,
            statusMessage: "C?? l???i t??? m??y ch???, vui l??ng th??? l???i sau!",
            data: JDIResponse.create(AppConstants.JDI_SERVER_ERROR, "C?? l???i t??? m??y ch???, vui l??ng th??? l???i sau!", 0, null)
        );
      } else if (DioErrorType.DEFAULT == e.type && e.message.contains('SocketException')) {
        return Response(
            statusCode: 999,
            statusMessage: "Kh??ng c?? k???t n???i internet vui l??ng th??? l???i sau!",
            data: JDIResponse.create(AppConstants.JDI_ERROR_SOCKET_EXCEPTION, "Kh??ng c?? k???t n???i internet vui l??ng th??? l???i sau!", 0, null)
        );
      } else {
        return Response(
            statusCode: 999,
            statusMessage: "C?? l???i k???t n???i m??y ch??? vui l??ng th??? l???i sau!",
            data: JDIResponse.create(AppConstants.JDI_ERROR_UNDEFINED, "C?? l???i k???t n???i m??y ch??? vui l??ng th??? l???i sau!", 0, null)
        );
      }
    }
  }

  Future<Response> put(String url,
      {Map<String, String> headers,
      Map<String, dynamic> mapData,
      FormData formData}) async {
    Response response = await _dio.put(url,
        data: (mapData == null) ? formData : mapData,
        options: Options(responseType: ResponseType.json, headers: headers));
    return response;
  }

  Future<Response> delete(String url, Map<String, dynamic> data,
      {Map<String, String> headers}) async {
    Response response = await _dio.delete(url,
        data: data,
        options: Options(responseType: ResponseType.json, headers: headers));
    return response;
  }
}

final networkUtil = NetworkUtil();

