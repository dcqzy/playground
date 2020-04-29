import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground/common/CustomImages.dart';
import 'package:playground/i18n/CustomLocalzation.dart';
import 'package:playground/model/RowItem.dart';
import 'package:playground/pages/main/HomePage.dart';
import 'package:playground/pages/main/SettingVIew.dart';
import 'package:playground/pages/main/UserPage.dart';

class MainPage extends StatefulWidget {
  static final String pageName = 'main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  List<RowItem> settings = [];

  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TabController controller;

  List<RowItem> pages = [
    RowItem(identify: 'home', data: HomePage()),
    RowItem(identify: 'user', data: UserPage()),
  ];

  @override
  void initState() {
    controller = TabController(vsync: this, length: pages.length);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    settings = [
      RowItem(title: LocalizedString(context).settings, identify: 'setting'),
    ];
    super.didChangeDependencies();
  }

  String getPageName(String identify) {
    switch (identify) {
      case 'user':
        return LocalizedString(context).user_page_name;
      case 'home':
        return LocalizedString(context).home_page_name;
      default:
        return '';
    }
  }

  Icon getIcon(String identify) {
    switch (identify) {
      case 'home':
        return Icon(Icons.home);
      case 'user':
        return Icon(Icons.person);
      default:
        return Icon(Icons.data_usage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      drawer: DrawView(),
      bottomNavigationBar: Container(
        child: TabBar(
          controller: controller,
          tabs: pages
              .map((item) => Tab(
                    text: getPageName(item.identify),
                    icon: getIcon(item.identify),
                  ))
              .toList(),
        ),
        color: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          key.currentState.openDrawer();
        },
        child: Icon(Icons.settings),
        splashColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: pages.map((item) => item.data as Widget).toList(),
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
//    return GamePage();
  }
}

/// the overlay [Draw] of the Scaffold on the leading side
class DrawView extends StatelessWidget {
  final List<RowItem> settings = [RowItem(identify: 'setting')];

//  DrawView(this.settings);

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

  String getItemName(BuildContext context, String identify) {
    switch (identify) {
      case 'setting':
        return LocalizedString(context).settings;
      default:
        return '';
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
            Text(getItemName(context, item.identify)),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SafeArea(
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
