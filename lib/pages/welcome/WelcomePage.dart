import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:playground/common/Config.dart';
import 'package:playground/common/CustomImages.dart';
import 'package:playground/pages/main/MainPage.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool showAd = false;

  int secondRemain = 0;

  TimerUtil util = TimerUtil(mTotalTime: 4000);

  @override
  void initState() {
    showAd = SpUtil.getBool(Config.welcomePageNeededKey, defValue: true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    util.setOnTimerTickCallback((int tick) {
      secondRemain = tick ~/ 1000;
      this.setState(() {});
      if (secondRemain == 0) {
        jumpToMainPage();
      }
    });
    util.startCountDown();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    util.setOnTimerTickCallback(null);
    util.cancel();
    super.dispose();
  }

  void jumpToMainPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(MainPage.pageName, (_) => false);
  }

  Widget buildAd() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        assetImage(CustomImages.splash_bg, fit: BoxFit.fill),
        Positioned(
          bottom: 30,
          right: 30,
          child: GestureDetector(
            onTap: () {
              jumpToMainPage();
            },
            child: Container(
              color: Colors.grey,
              padding: EdgeInsets.all(10),
              child: Text(
                '跳过($secondRemain)',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: buildAd(),
    )));
  }
}
