import 'package:flutter/cupertino.dart';
import 'package:playground/bloc/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc implements BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();

  Sink<int> get _appEventSink => _appEvent.sink;

  Stream<int> get appEventStream => _appEvent.stream;

  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }

  BehaviorSubject<bool> _systemIsInDarkMode = BehaviorSubject<bool>();

  Sink<bool> get _systemIsInDarkModeSink => _systemIsInDarkMode.sink;

  Stream<bool> get systemIsInDarkModeStream => _systemIsInDarkMode.stream;

  void broadcastAppThemeModeChanges({@required bool isDarkMode}) {
    _systemIsInDarkModeSink.add(isDarkMode);
  }

  @override
  void dispose() {
    _appEvent.close();
  }

  @override
  Future getData({String labelId, int page}) {
    // TODO: implement getData
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    // TODO: implement onLoadMore
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    // TODO: implement onRefresh
    return null;
  }
}
