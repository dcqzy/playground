import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'LocaleModel.g.dart';

@JsonSerializable()
class LocaleModel {
  /// e.g 'zh' 'en'
  String languageCode;

  /// e.g 'US' 'CN'
  String countryCode;

  LocaleModel({
    this.countryCode,
    this.languageCode,
  });

  factory LocaleModel.fromJson(Map<String, dynamic> json) => _$LocaleModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocaleModelToJson(this);

  Locale get castToLocaleClass => Locale(this.languageCode, this.countryCode);
}
