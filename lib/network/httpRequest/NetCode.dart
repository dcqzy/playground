import 'package:event_bus/event_bus.dart';
import 'package:playground/network/httpRequest/HttpErrorEvent.dart';

class NetCode {
  ///网络错误
  static const NETWORK_ERROR = -1;

  ///网络超时
  static const NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化错误
  static const NETWORK_JSON_EXCEPTION = -3;

  ///取消
  static const NETWORK_CANCEL = -4;

  ///未知错误
  static const NETWORK_UNKNOWN = -5;

  static const SUCCESS = 200;

  static const UNAUTHORIZED = 401;

  static const HTTP_START = -6;

  static const HTTP_END = -7;

  static final EventBus eventBus = EventBus();

  static errorHandle(code, message, {tip = true}) {
    if (tip) eventBus.fire(HttpErrorEvent(code, message));
    return message;
  }

  static progressHandle(int code) {
    eventBus.fire(HttpProgressEvent(code));
  }
}
