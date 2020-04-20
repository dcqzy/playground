import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart' as LocaleUtils;
import 'package:playground/bloc/application_bloc.dart';
import 'package:playground/bloc/bloc_provider.dart';
import 'package:playground/bloc/main_bloc.dart';
import 'package:playground/common/Config.dart';
import 'package:playground/common/Global.dart';
import 'package:playground/common/style/CustomColors.dart';
import 'package:playground/common/widgets/Toast.dart';
import 'package:playground/i18n/CustomLocalzation.dart' as locale;
import 'package:playground/network/HttpEvent.dart';
import 'package:playground/network/httpRequest/NetCode.dart';
import 'package:playground/pages/main/MainPage.dart';
import 'package:playground/pages/welcome/WelcomePage.dart';

void main() {
  Global.init(() {
    runApp(BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: BlocProvider(
        child: MyApp(),
        bloc: MainBloc(),
      ),
    ));
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  Color _themeColor = Color(0xFF666666);

  @override
  void initState() {
    initAll();
    super.initState();
  }

  void initAll() {
    _initTheme();
    _initLocale();
    _initListener();
  }

  void _initHttpConfig() {
    /// null
  }

  void _initLocale() {
    String code = SpUtil.getString(Config.localeSettingKey);
    _locale = locale.CustomLocalizations.codeToLocales[code];
    if (_locale == null) {
      try {
        _locale = Localizations.localeOf(context);
      } catch (e) {
        _locale = null;
      } finally {
        _locale = _locale ?? const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN');
      }
    }
  }

  void _initListener() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      refreshApplicationGlobalSettings();
    });
  }

  void _initTheme() {
    String temp = SpUtil.getString(Config.themeSettingKey);
    _themeColor = defaultThemeList[temp];
  }

  void refreshApplicationGlobalSettings() {
    this.setState(() {
      _initLocale();
      _initTheme();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          MainPage.pageName: (ctx) => MainPage(),
        },
        home: WelcomePage(),
        locale: _locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: _themeColor,
          accentColor: _themeColor,
        ),
        localizationsDelegates: [
          LocaleUtils.GlobalMaterialLocalizations.delegate,
          LocaleUtils.GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          locale.CustomLocalizationsDelegate.delegate,
        ],
        supportedLocales: locale.CustomLocalizations.supportedLocals);
  }
}

class CustomLocalizations extends StatefulWidget {
  final Widget child;

  CustomLocalizations({Key key, this.child}) : super(key: key);

  @override
  _LocalizationsState createState() => _LocalizationsState();
}

class _LocalizationsState extends State<CustomLocalizations> {
  StreamSubscription stream;

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    stream = NetCode.eventBus.on<HttpEvent>().listen((event) {
      if (event is HttpErrorEvent) {
        httpErrorEvent(event.code, event.message);
      } else if (event is HttpProgressEvent) {
        httpProgressEvent(event.code);
      }
    });
  }

  @override
  void dispose() {
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
    super.dispose();
  }

  void httpProgressEvent(int code) {
    if (code == NetCode.HTTP_START) {
      Toast.showLoading(context, locale.LocalizedString(context).waiting);
    } else if (code == NetCode.HTTP_END) {
      Toast.close(context);
    }
  }

  void httpErrorEvent(int code, message) {
    switch (code) {
      case NetCode.NETWORK_ERROR:
        Toast.showToast(msg: locale.LocalizedString(context).network_error);
        break;
      case NetCode.NETWORK_JSON_EXCEPTION:
      case NetCode.NETWORK_UNKNOWN:
        Toast.showToast(msg: locale.LocalizedString(context).network_error_unknown);
        break;
      case NetCode.UNAUTHORIZED:
//        if (widget.child is! LoginPage) {
//          if (User.current.authentication != null) {
//            Toast.showToast(msg: message ?? LocalizedString(context).network_error_401);
//            UserDao.clearLoginInfo();
////            Future.delayed(Duration(seconds: 1), () => NavigatorUtils.goLogin(context));
//            Future.delayed(Duration(seconds: 1)).then((_) {
//              NavigatorUtils.goLogin(context);
//            });
//          }
//        } else {
//          Toast.showToast(msg: message ?? LocalizedString(context).network_error_401);
//        }
        break;
      case 403:
        Toast.showToast(msg: locale.LocalizedString(context).network_error_403);
        break;
      case 404:
        Toast.showToast(msg: locale.LocalizedString(context).network_error_404);
        break;
      case 500:
        Toast.showToast(msg: locale.LocalizedString(context).network_error_500);
        break;
      case NetCode.NETWORK_TIMEOUT:
        //超时
        Toast.showToast(msg: locale.LocalizedString(context).network_error_timeout);
        break;
      default:
        if (message != null) {
          Toast.showToast(msg: message);
        }
        break;
    }
  }
}
