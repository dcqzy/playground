import 'dart:convert';

import 'package:playground/network/httpRequest/NetCode.dart';

class NetResult {
  var result;

  int total;

  bool error;

  int statusCode;

  String errorMessage;

  bool get success => !error;

  get res => result as Map;

  NetResult({
    this.result,
    this.statusCode,
    this.error,
    this.errorMessage,
    this.total,
  });

  static const statusCodeKey = 'code';

  static const receiveRightCodeValue = 0;

  static const resultBodyKey = 'statusContent';

  static const resultErrorKey = 'statusContent';

  NetResult.fetch({
    var data,
    bool error = true,
    int statusCode,
  }) {
    this.statusCode = statusCode;
    var receiveData;
    if (data != null && data != '') {
      if (data is String) {
        receiveData = json.decode(data);
      } else {
        receiveData = data;
      }
    }
    this.error = error;
    if (!error && receiveData is Map) {
      total = receiveData['total'];
      statusCode = receiveData['idStatus'];
      errorMessage = receiveData['statusContent'];
    }
    if (error) {
      if (receiveData is Map) {
        errorMessage = receiveData[resultErrorKey];
      } else {
        statusCode = NetCode.NETWORK_UNKNOWN;
      }
    }
    result = receiveData;
  }

  @override
  String toString() {
    return '------------print message--------\nNetResult：statusCode: $statusCode \n'
        'NetResult: error: $error errorMessage: $errorMessage \n'
        'NetResult: result: ${result.toString()}';
  }
}
