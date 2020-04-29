import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playground/bloc/bloc_provider.dart';
import 'package:playground/bloc/main_bloc.dart';
import 'package:playground/common/widgets/RefreshController.dart';
import 'package:playground/i18n/CustomLocalzation.dart';
import 'package:playground/model/BannerModel.dart';
import 'package:playground/model/RowItem.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  List<RowItem> sections = [
    RowItem(identify: 'banner'),
  ];

  Widget getSections(String identify, MainBloc bloc) {
    switch (identify) {
      case 'banner':
        return buildBanner(bloc);
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }

  void refreshData(MainBloc bloc) {
    bloc.getBanner();
    refreshController.refreshCompleted();
  }

  Widget buildBanner(MainBloc bloc) {
    return StreamBuilder(
      stream: bloc.bannerStream,
      builder: (BuildContext context, AsyncSnapshot<List<BannerModel>> snapshot) {
        if (snapshot.hasData) {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: Swiper(
              children: snapshot.data
                  .map((item) => CachedNetworkImage(
                        imageUrl: item.imagePath,
                      ))
                  .toList(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return CupertinoActivityIndicator();
        } else if (snapshot.hasError) {
          return Icon(Icons.error);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = BlocProvider.of<MainBloc>(context);
    return Scaffold(
      appBar: AppBar(
//        brightness: SpUtil.getBool(Config.themeIsDarkMode) ? Brightness.dark : Brightness.light,
        title: Text(LocalizedString(context).home_page_name),
      ),
      body: pullRefreshListWidget(context,
          controller: refreshController,
          onRefresh: () {
            refreshData(bloc);
          },
          itemBuilder: (BuildContext context, int index) => Column(
                children: sections.map((item) => getSections(item.identify, bloc)).toList(),
              ),
          itemCount: 1),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
