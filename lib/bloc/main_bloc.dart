import 'package:playground/bloc/bloc_provider.dart';
import 'package:playground/model/BannerModel.dart';
import 'package:playground/network/dao(repo)/HomeDao.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc implements BlocBase {
  BehaviorSubject<List<BannerModel>> _banner = BehaviorSubject<List<BannerModel>>();

  Sink<List<BannerModel>> get _bannerSink => _banner.sink;

  Stream<List<BannerModel>> get bannerStream => _banner.stream;

  Future getBanner() {
    return HomeDao.getHomeBanner().then((value) {
      _bannerSink.add(value);
    });
  }

  @override
  void dispose() {
    _banner.close();
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
