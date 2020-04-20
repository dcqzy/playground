// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocaleModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocaleModel _$LocaleModelFromJson(Map<String, dynamic> json) {
  return LocaleModel(
    countryCode: json['countryCode'] as String,
    languageCode: json['languageCode'] as String,
  );
}

Map<String, dynamic> _$LocaleModelToJson(LocaleModel instance) =>
    <String, dynamic>{
      'languageCode': instance.languageCode,
      'countryCode': instance.countryCode,
    };
