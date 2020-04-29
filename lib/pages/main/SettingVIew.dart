import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:playground/bloc/application_bloc.dart';
import 'package:playground/bloc/bloc_provider.dart';
import 'package:playground/common/Config.dart';
import 'package:playground/common/style/CustomColors.dart';
import 'package:playground/i18n/CustomLocalzation.dart';
import 'package:playground/model/RowItem.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> with WidgetsBindingObserver {
  String userSelectedColor;

  List<RowItem> locales;

  bool isDarkMode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    isDarkMode = SpUtil.getBool(Config.themeIsDarkMode);
    userSelectedColor = SpUtil.getString(Config.themeSettingKey);
    updateLocaleSettings(isInit: true);
    super.didChangeDependencies();
  }

  @override
  void didChangePlatformBrightness() {
    isDarkMode = SpUtil.getBool(Config.themeIsDarkMode);
    this.setState(() {});
    super.didChangePlatformBrightness();
  }

  void updateLocaleSettings({bool isInit = false}) {
    locales = CustomLocalizations.localizedValues.keys
        .map((item) => RowItem(title: CustomLocalizations.getLanguageNameFromCode(context, item), subTitle: item))
        .toList();
    String languageCode = SpUtil.getString(Config.localeSettingKey);
    locales.forEach((item) {
      item.selected = item.subTitle == languageCode;
    });
    if (!isInit) this.setState(() {});
  }

  Widget buildThemeSelectPanel(ApplicationBloc applicationBloc, bool enable) {
    List<Widget> children = [
      ExpansionTile(
        title: Text(LocalizedString(context).theme),
        children: <Widget>[
          Wrap(
            children: List.generate(defaultThemeList.length + 1, (index) {
              if (index == 0) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(7.5),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                    ),
                    Container(
                      width: 2,
                      height: 30,
                      color: Colors.grey,
                    )
                  ],
                );
              }
              String colorStringKey = defaultThemeList.keys.toList()[--index];
              Color color = defaultThemeList[colorStringKey];
              return GestureDetector(
                onTap: () {
                  SpUtil.putString(Config.themeSettingKey, colorStringKey);
                  applicationBloc.sendAppEvent(1);
                },
                child: Container(
                  margin: EdgeInsets.all(7.5),
                  child: Container(
                    decoration: BoxDecoration(color: color),
                    width: 30,
                    height: 30,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ];
    if (!enable) {
      children.addAll(<Widget>[
        Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.5,
              child: Container(
                color: Theme.of(context).primaryColor,
              ),
            )),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          bottom: 0,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              LocalizedString(context).theme_cannot_changed_now_promet,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]);
    }
    return Stack(
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizedString(context).settings),
      ),
      body: Column(
        children: <Widget>[
          buildThemeSelectPanel(applicationBloc, !isDarkMode),
          ExpansionTile(
            title: Text(LocalizedString(context).international),
            children: locales
                .map((item) => GestureDetector(
                      onTap: item.selected
                          ? () {}
                          : () {
                              SpUtil.putString(Config.localeSettingKey, item.subTitle);
                              applicationBloc.sendAppEvent(1);
                              updateLocaleSettings();
                            },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(item.title),
                            Icon(item.selected ? Icons.radio_button_checked : Icons.radio_button_unchecked)
                          ],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
