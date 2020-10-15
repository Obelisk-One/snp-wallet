/*
 * @Project:        snp
 * @Package:        ui.pages.board
 * @FileName:       board_home_page
 * @Create:         2020/8/27 2:17 PM
 * @Description:    
 * @author          dt
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:snp/beans/alliance_apply_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/event_bus_util.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/pages/board/invite_user_view.dart';
import 'package:snp/ui/pages/board/store/board_home.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/alliance_apply_cell_view.dart';
import 'package:snp/ui/widgets/avatar_view.dart';
import 'package:snp/ui/widgets/circle_loader_view.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';
import 'package:snp/ui/widgets/tab_view.dart';
import 'package:snp/ui/widgets/web_image_view.dart';

class BoardHomePage extends StatefulWidget {
  @override
  _BoardHomePageState createState() => _BoardHomePageState();
}

class _BoardHomePageState extends BaseState<BoardHomePage>
    with TickerProviderStateMixin {
  final BoardHomeStore _store = BoardHomeStore();
  final LinkHeaderNotifier _headerNotifier = LinkHeaderNotifier();

  TabController _tabController;
  ScrollController _scrollController;
  EasyRefreshController _refreshController;

  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh.custom(
        controller: _refreshController,
        scrollController: _scrollController,
        header: LinkHeader(
          _headerNotifier,
          completeDuration: Duration(milliseconds: 500),
        ),
        footer: BallPulseFooter(
          color: CColor.mainColor,
          enableInfiniteLoad: false,
        ),
        slivers: <Widget>[
          Observer(
            name: 'header',
            builder: (_) => SliverAppBar(
              centerTitle: true,
              title: Opacity(
                opacity: _store.titleOpacity,
                child: Text(
                  '联盟名称',
                  style: Font.title,
                ),
              ),
              brightness: _store.brightness,
              pinned: true,
              expandedHeight: statusBarHeight + 240,
              flexibleSpace: FlexibleSpaceBar(
                background: _renderHeader(),
              ),
              leading: CircleLoader(_headerNotifier),
            ),
          ),
          Observer(
            name: 'tab',
            builder: (_) => SliverToBoxAdapter(
              child: TabView(
                tabs: ['声誉分布', 'FEC分布'],
                views: <Widget>[
                  _renderChartView(_store.fameData),
                  _renderChartView(_store.fecData),
                ],
                tabsAlignLeft: true,
                tabMargin: sInsetsHV(15, 0),
                height: 200,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: gap(height: 20),
          ),
          SliverToBoxAdapter(
            child: Divider(
              thickness: 10,
              color: CColor.bgGrayColor,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: sInsetsHV(15, 0),
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: CColor.mainColor,
                    labelColor: CColor.lightTextColor,
                    labelStyle: Font.lightL,
                    unselectedLabelColor: CColor.minorTextColor,
                    unselectedLabelStyle: Font.minorL,
                    tabs: <Widget>[
                      Tab(text: "人员管理"),
                      Tab(text: "人员激励"),
                    ],
                  ),
                ),
                Observer(
                  builder: (_) => Visibility(
                    visible: globalMainStore.isInAlliance,
                    child: FlatButton(
                      child: Row(
                        children: [
                          Icon(
                            SnpIcon.invite,
                            size: 17,
                            color: CColor.mainColor,
                          ),
                          Text(
                            ' 引入新成员',
                            style: Font.lightS,
                          ),
                        ],
                      ),
                      color: Colors.transparent,
                      onPressed: () =>
                          RouteUtil.showModelPage(InviteUserView()),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverVisibility(
            visible: _showFirst,
            sliver: Observer(
              builder: (_) => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index < _store.applyList.length)
                      return AllianceApplyCell(_store.applyList[index]);
                    else
                      return Container(
                        height: sHeight(50),
                        child: Center(
                          child: Text(
                            _store.applyList.isEmpty
                                ? '暂无数据'
                                : _store.noMore
                                    ? '-----我是有底线的-----'
                                    : _store.isError ? '获取数据失败,请重试' : '',
                            style: Font.hintS,
                          ),
                        ),
                      );
                  },
                  childCount: _store.applyList.length + 1,
                ),
              ),
            ),
          ),
          SliverVisibility(
            visible: !_showFirst,
            sliver: SliverFixedExtentList(
              itemExtent: _showFirst ? 0 : 30,
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightGreen[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
        ],
        onRefresh: () async {
          // await Future.delayed(Duration(seconds: 2), () {});
          await _store.fetchAllianceApply(true);
          await _store.fetchAllianceStimulate();
        },
        onLoad: _showFirst && !_store.noMore
            ? () async {
                await _store.fetchAllianceApply(false);
              }
            : null,
      ),
    );
  }

  _renderChartView(Map data) => Container(
        margin: sInsetsHV(15, 10),
        decoration: BoxDecoration(
          color: CColor.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: CColor.shadowColor,
              offset: Offset(0.0, 2.0),
              blurRadius: 9.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: sWidth(120),
              height: sWidth(120),
              margin: sInsetsAll(10),
              child: Stack(
                children: [
                  PieChart(
                    PieChartData(
                      sections: data.values
                          .map((e) => PieChartSectionData(
                                value: e['value'],
                                radius: sWidth(20),
                                color: e['color'],
                                showTitle: false,
                              ))
                          .toList(),
                      centerSpaceRadius: sWidth(40),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                  Center(
                    child: Text(
                      '111',
                      style: Font.normalH,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.keys
                  .map(
                    (e) => Padding(
                      padding: sInsetsHV(10, 5),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Container(
                              width: 6,
                              height: 6,
                              color: data[e]['color'],
                            ),
                          ),
                          gap(width: 5),
                          Text(
                            e,
                            style: Font.minorS,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );

  _renderHeader() => Stack(
        children: [
          Container(
            margin: sInsetsLTRB(0, 0, 0, 45, sc: false),
            width: screenWidth,
            color: CColor.mainColor,
            child: Column(
              children: [
                gap(height: statusBarHeight, sc: false),
                Expanded(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2392853673,4010987567&fm=26&gp=0.jpg",
                        fit: BoxFit.cover,
                        width: 60,
                        height: 44,
                      ),
                    ),
                  ),
                ),
                Text(
                  '联盟名称',
                  style: Font.overMain,
                ),
                Container(
                  margin: sInsetsLTRB(15, 10, 15, 45, sc: false),
                  padding: sInsetsAll(10),
                  decoration: BoxDecoration(
                    color: Color(0x28FFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '联盟的简介：文本文本文本文本文本文本文文本文本文本文本文本文本文本文本文文本文本文本文本文本文本文本文本文文本文本文本文本文本文本文本文本文文本文本',
                        style: Font.overMainS,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      gap(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '由@AAD最后修订',
                            style: Font.overMainXS,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              'assets/images/icon_header_right.png',
              width: 95,
              height: 105,
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: sInsetsHV(15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _card('我的声誉', '116', CColor.orange),
                  _card('新增FEC', '216.68', CColor.green),
                ],
              ),
            ),
          ),
        ],
      );

  _card(title, value, color) => Container(
        width: (screenWidth - sWidth(40)) / 2,
        height: 70,
        decoration: BoxDecoration(
          color: CColor.cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: CColor.shadowColor,
              offset: Offset(0.0, 2.0),
              blurRadius: 9.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 6,
                      height: 6,
                      color: color,
                    ),
                  ),
                  gap(width: 5),
                  Text(
                    title,
                    style: Font.minorXS,
                  ),
                ],
              ),
              gap(height: 5),
              Text(
                value,
                style: TextStyle(
                  color: CColor.textColor,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() {
        if (_tabController.index.toDouble() == _tabController.animation.value)
          sState(() => _showFirst = _tabController.index == 0);
      });
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= 200)
          _store.setBrightness(Brightness.light);
        else if (_scrollController.offset < 200)
          _store.setBrightness(Brightness.dark);
        double opacity = (_scrollController.offset - 150).round() / 50;
        opacity = opacity > 1 ? 1 : (opacity < 0 ? 0 : opacity);
        _store.setTitleOpacity(opacity);
      });
    _refreshController = EasyRefreshController();
    bus.on(
      Config.event_bus_switch_alliance,
      (arg) => _refreshController.callRefresh(),
    );
  }

  @override
  void onResume() {
    _refreshController.callRefresh();
    super.onResume();
  }

  @override
  void dispose() {
    bus.off(Config.event_bus_switch_alliance);
    _tabController = null;
    _scrollController = null;
    _refreshController = null;
    super.dispose();
  }
}
