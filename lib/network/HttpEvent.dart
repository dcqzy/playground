abstract class HttpEvent {
  final int code;

  HttpEvent(this.code);
}

class HttpErrorEvent extends HttpEvent {
  final String message;

  HttpErrorEvent(code, this.message) : super(code);
}

class HttpProgressEvent extends HttpEvent {
  HttpProgressEvent(code) : super(code);
}
