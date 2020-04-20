import 'package:json_annotation/json_annotation.dart';

part 'BannerModel.g.dart';

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
