import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:playground/i18n/LocalString.dart';
import 'package:playground/i18n/LocalStringEN.dart';
import 'package:playground/i18n/LocalStringJA.dart';
import 'package:playground/i18n/LocalStringZH.dart';

class CustomLocalizations {
  final Locale locale;

  CustomLocalizations(this.locale);

  static Map<String, LocalString> localizedValues = {
    'en': LocalStringUS(),
    'zh': LocalStringZH(),
    'ja': LocalStringJP(),
  };

  static Map<String, Locale> codeToLocales = {
    'en': Locale('en', 'US'),
    'zh': Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'), // 'zh_Hans_CN'
    'ja': Locale('ja', 'JP'),
  };

  static const List<Locale> supportedLocals = [
    const Locale('en'),
    const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'), // 'zh_Hans_CN'
    const Locale('ja', 'JP'),
  ];

  LocalString get currentLocalized {
    return localizedValues[locale.languageCode];
  }

  static CustomLocalizations of(BuildContext context) {
    return Localizations.of(context, CustomLocalizations);
  }

  static String getLanguageNameFromCode(BuildContext context, String code) {
    switch (code) {
      case 'en':
        return LocalizedString(context).international_English;
      case 'ja':
        return LocalizedString(context).international_Japanese;
      case 'zh':
        return LocalizedString(context).international_simpified_Chinese;
      case 'hk':
        return LocalizedString(context).international_traditional_Chinese;
      default:
        return '';
    }
  }
}

final LocalizedString = (BuildContext context) => CustomLocalizations.of(context).currentLocalized;

class CustomLocalizationsDelegate extends LocalizationsDelegate<CustomLocalizations> {
  CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // 支持中文和英语
    return ['en', 'zh', 'ja', 'hk'].contains(locale.languageCode);
  }

  @override
  Future<CustomLocalizations> load(Locale locale) {
    // 根据locale，创建一个对象用于提供当前locale下的文本
    return SynchronousFuture<CustomLocalizations>(CustomLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<CustomLocalizations> old) {
    return false;
  }

  static LocalizationsDelegate delegate = CustomLocalizationsDelegate();
}
