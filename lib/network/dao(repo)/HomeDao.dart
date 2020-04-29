import 'package:playground/model/BannerModel.dart';
import 'package:playground/network/NetAddress.dart';
import 'package:playground/network/httpRequest/NetResult.dart';
import 'package:playground/network/httpRequest/Request.dart';

class HomeDao {
  static Future<List<BannerModel>> getHomeBanner() async {
    NetResult netResult = await Request.request(Address.getBanner, method: 'GET');
    if (netResult.success) {
      List list = netResult.res['data'];
      return List.generate(list.length, (index) => BannerModel.fromJson(list[index]));
    } else {
      return null;
    }
  }
}
