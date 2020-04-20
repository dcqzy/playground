import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground/common/CustomImages.dart';
import 'package:playground/i18n/CustomLocalzation.dart';
import 'package:playground/model/RowItem.dart';
import 'package:playground/pages/main/SettingVIew.dart';

class MainPage extends StatefulWidget {
  static final String pageName = 'main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<RowItem> settings = [];

  @override
  void didChangeDependencies() {
    settings = [
      RowItem(title: LocalizedString(context).settings, identify: 'setting'),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: DrawView(settings),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(LocalizedString(context).hello_world),
      ),
    );
  }
}

class DrawView extends StatelessWidget {
  final List<RowItem> settings;

  DrawView(this.settings);

  Icon getIcons(String identify) {
    switch (identify) {
      case 'setting':
        return Icon(Icons.settings, size: 22);
      default:
        return Icon(Icons.settings, size: 0);
    }
  }

  Widget getPage(String identify) {
    switch (identify) {
      case 'setting':
        return SettingView();
      default:
        return null;
    }
  }

  Widget buildSections(BuildContext context, RowItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, CupertinoPageRoute(builder: (context) => getPage(item.identify)));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            getIcons(item.identify),
            Text(item.title),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                ClipOval(
                  child: assetImage(CustomImages.mahira, width: 100, height: 100),
                ),
                Text('dcqzy'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: settings.map((item) => buildSections(context, item)).toList(),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
