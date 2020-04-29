import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Widget pullRefreshListWidget(BuildContext context,
    {@required RefreshController controller,
    @required IndexedWidgetBuilder itemBuilder,
    @required int itemCount,
    bool enablePullUp = false,
    bool enablePullDown = true,
    bool shrinkWrap = true,
    VoidCallback onRefresh,
    VoidCallback onLoading,
    EdgeInsetsGeometry padding,
    Widget header,
    Widget footer,
    Widget placeholder,
    bool isCourse = false}) {
  return SmartRefresher(
    enablePullDown: enablePullDown,
    enablePullUp: enablePullUp,
    controller: controller,
    onRefresh: onRefresh,
    onLoading: onLoading,
    child: ListView.builder(
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemBuilder: itemCount != 0
          ? itemBuilder
          : (context, index) {
              return Container();
            },
      itemCount: itemCount == 0 ? 1 : itemCount,
    ),
  );
}
