import 'package:json_annotation/json_annotation.dart';

part 'BannerModel.g.dart';

//desc: "享学~",
//id: 29,
//imagePath: "https://www.wanandroid.com/blogimgs/dae161d5-fd4e-4c7e-8d53-b2f41bc3100e.png",
//isVisible: 1,
//order: 0,
//title: "Jetpack能否一统江湖？",
//type: 0,
//url: "https://mp.weixin.qq.com/s/-89vkJslFTMFWxkJkn0yug"

@JsonSerializable()
class BannerModel {
  String title;
  int id;
  String url;
  String imagePath;

  BannerModel({
    this.title,
    this.id,
    this.imagePath,
    this.url,
  });
  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
