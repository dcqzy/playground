// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BannerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return BannerModel(
    title: json['title'] as String,
    id: json['id'] as int,
    imagePath: json['imagePath'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'url': instance.url,
      'imagePath': instance.imagePath,
    };
