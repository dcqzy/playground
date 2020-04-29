import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:playground/network/httpRequest/NetCode.dart';
import 'package:playground/network/httpRequest/NetResult.dart';

class Request {
  static const authorizationKey = 'Authorization';

  Dio dio;

  factory Request() => _getInstance();

  static Request get instance => _getInstance();

  static Request _instance;

  static Request _getInstance() {
    if (_instance == null) _instance = Request._internal();
    return _instance;
  }

  Request._internal() {
    dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  static Future<NetResult> request(
    String path, {
    String method = 'POST',
    data,
    Map<String, dynamic /*String|Iterable<String>*/ > queryParameters,
    CancelToken cancelToken,
    ProgressCallback onUploadProgress,
    bool contentTypeXForm = true,
    Map<String, dynamic> headers,
    bool errorToast = true,
    bool loadingToast = false,
    bool serviceToast = true,
  }) async {
    if (loadingToast) NetCode.progressHandle(NetCode.HTTP_START);

    Map<String, dynamic> headerMap = Map();
    if (headers != null) headerMap.addAll(headers);
//    String auth = await UserDao.authentication;
//    if (auth != null) headerMap[authorizationKey] = 'Bearer $auth';
//    headerMap['origin'] = Address.requestOrigin;

    Dio dio = Request.instance.dio;
    Options options = Options(
        method: method, contentType: contentTypeXForm ? "application/x-www-form-urlencoded" : null, headers: headerMap);

//    if (data is FileFormData) {
//      data = (data as FileFormData).formData;
//    }

    NetResult result;
    try {
      Response response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onUploadProgress,
      );
      result = NetResult.fetch(
        data: response.data,
        statusCode: response.statusCode,
        error: response.data['idStatus'] as int != 200,
      );
    } on DioError catch (e) {
      result = await errorResult(e);
    }
    if (loadingToast) NetCode.progressHandle(NetCode.HTTP_END);
    if (errorToast) NetCode.errorHandle(result.statusCode, result.errorMessage);
    return result;
  }

  static Future<NetResult> errorResult(DioError e) async {
    int statusCode = NetCode.NETWORK_UNKNOWN;
    if (e.response != null) {
      statusCode = e.response.statusCode;
    } else {
      ConnectivityResult connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        statusCode = NetCode.NETWORK_ERROR;
      } else if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        statusCode = NetCode.NETWORK_TIMEOUT;
      } else if (e.type == DioErrorType.CANCEL) {
        statusCode = NetCode.NETWORK_CANCEL;
      }
    }
    return NetResult.fetch(
      error: true,
      statusCode: statusCode,
      data: e.response?.data,
    );
  }
}
