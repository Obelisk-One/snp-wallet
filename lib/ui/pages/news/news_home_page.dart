/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       news_home_page
 * @Create:         2020/8/27 2:16 PM
 * @Description:    动态
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/pages/news/alliance_brief_page.dart';
import 'package:snp/ui/pages/news/fresh_new_list_page.dart';
import 'package:snp/ui/pages/news/top_news_list_page.dart';
import 'package:snp/ui/pages/news/post_content_view.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/store/user.dart';

class NewsHomePage extends StatefulWidget {
  const NewsHomePage({Key key}) : super(key: key);

  @override
  _NewsHomePageState createState() => new _NewsHomePageState();
}

class _NewsHomePageState extends State<NewsHomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Container(
          child: TabBar(
            controller: _controller,
            indicatorColor: CColor.mainColor,
            labelColor: CColor.lightTextColor,
            labelStyle: Font.lightL,
            unselectedLabelColor: CColor.minorTextColor,
            unselectedLabelStyle: Font.minorL,
            tabs: <Widget>[
              Tab(text: "最新"),
              Tab(text: "排行"),
            ],
          ),
        ),
        leading: IconButton(
          icon: Icon(
            SnpIcon.alliance,
            size: sFontSize(20),
            color: CColor.iconColor,
          ),
          onPressed: () => globalMainStore.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              SnpIcon.brief,
              size: sFontSize(20),
              color: CColor.iconColor,
            ),
            onPressed: () => push(AllianceBriefPage()),
          ),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          FreshNewList(),
          TopNewsList(),
        ],
      ),
      floatingActionButton: Observer(
        builder: (_) => Visibility(
          visible: globalMainStore.isInAlliance,
          child: FloatingActionButton(
            onPressed: () => RouteUtil.showModelPage(
              PostContentPage(),
            ),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
    globalMainStore.checkIsInAlliance();
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }
}
