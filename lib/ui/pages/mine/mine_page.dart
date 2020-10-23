/*
 * @Project:        snp
 * @Package:        ui.pages.mine
 * @FileName:       mine_page
 * @Create:         2020/8/27 2:14 PM
 * @Description:    
 * @author          dt
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:snp/beans/content_bean.dart';
import 'package:snp/beans/my_alliance_bean.dart';
import 'package:snp/beans/user_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:snp/ui/pages/mine/personal_page.dart';
import 'package:snp/ui/pages/mine/settings_page.dart';
import 'package:snp/ui/pages/mine/store/mine.dart';
import 'package:snp/ui/pages/news/content_detail_page.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/store/user.dart';
import 'package:snp/ui/widgets/avatar_view.dart';
import 'package:snp/ui/widgets/circle_loader_view.dart';
import 'package:snp/ui/widgets/content_cell_view.dart';
import 'package:snp/ui/widgets/tab_view.dart';
import 'package:snp/ui/widgets/web_image_view.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends BaseState<MinePage> {
  final LinkHeaderNotifier _headerNotifier = LinkHeaderNotifier();
  final MineStore _store = MineStore();
  final GlobalKey _key = GlobalKey();
  final double _allianceImageHeight = screenWidth / Config.allianceImageRatio;

  ScrollController _scrollController;
  EasyRefreshController _refreshController;
  double _headerHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
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
            SliverAppBar(
              centerTitle: true,
              title: Opacity(
                opacity: _store.titleOpacity,
                child: Text(
                  '我的',
                  style: Font.title,
                ),
              ),
              brightness: _store.brightness,
              pinned: true,
              expandedHeight: _headerHeight,
              leading: CircleLoader(_headerNotifier),
              actions: [
                IconButton(
                  icon: Icon(
                    SnpIcon.setting,
                    size: sFontSize(20),
                    color: _store.brightness == Brightness.dark
                        ? CColor.overMainTextColor
                        : CColor.iconColor,
                  ),
                  onPressed: () => push(SettingsPage()),
                ),
                gap(width: 10),
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Stack(
                  children: [
                    ObjectUtil.isEmpty(_store.currentAlliance)
                        ? SizedBox(
                            width: screenWidth,
                            height: _allianceImageHeight,
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ColoredBox(
                                    color: CColor.mainColor,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Image.asset(
                                    'assets/images/icon_header_right.png',
                                    fit: BoxFit.cover,
                                    width: 95 * 1.5,
                                    height: 105 * 1.5,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : WebImage(
                            url: _store.currentAlliance?.flagPic,
                            width: screenWidth,
                            height: _allianceImageHeight,
                          ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: statusBarHeight + appBarHeight + 20,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0x88000000),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: _allianceImageHeight - sHeight(35),
                      key: _key,
                      child: Column(
                        children: [
                          _renderPersonalCard(),
                          _store.myAlliances.isNotEmpty
                              ? TabView(
                                  tabs: _store.myAlliances
                                      .map((e) => e.name)
                                      .toList(),
                                  views: _store.myAlliances
                                      .map((e) => _renderAllianceCard(e))
                                      .toList(),
                                  tabsAlignLeft: true,
                                  initialIndex:
                                      _store.myAlliances.isNotEmpty ? 0 : -1,
                                  tabMargin: sInsetsHV(15, 0),
                                  height: sHeight(114) + sWidth(40),
                                  onChanged: (index) =>
                                      _store.switchAlliance(index),
                                )
                              : SizedBox(
                                  height: 215,
                                  width: screenWidth,
                                  child: Center(
                                    child: Text(
                                      '您还未加入任何联盟',
                                      style: Font.minorL,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverVisibility(
              visible: _store.myAlliances.isNotEmpty,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index < _store.contentList.length) {
                      ContentBean _bean = _store.contentList.elementAt(index);
                      return ContentCell(
                        bean: _bean,
                        showBottomLine: true,
                        margin: sInsetsLTRB(0, index == 0 ? 0 : 10, 0, 0),
                        onClick: (id) => push(ContentDetailPage(id: id)),
                      );
                    } else
                      return Container(
                        height: sHeight(50),
                        child: Center(
                          child: Text(
                            _store.contentList.isEmpty
                                ? '暂无数据'
                                : _store.noMore
                                    ? '-----我是有底线的-----'
                                    : _store.isError ? '获取数据失败,请重试' : '',
                            style: Font.hintS,
                          ),
                        ),
                      );
                  },
                  childCount:
                      _store.contentList.length + (_store.noMore ? 1 : 0),
                ),
              ),
            ),
          ],
          onRefresh: () async {
            await globalUserStore.fetchUserInfo();
            await _store.fetchMyAlliances();
            await _store.fetchContentList(true);
          },
          onLoad: _store.noMore
              ? null
              : () async => await _store.fetchContentList(false),
        ),
      ),
    );
  }

  _renderPersonalCard() => GestureDetector(
        onTap: () => globalUserStore.bean == null ? null : push(PersonalPage()),
        child: Container(
          margin: sInsetsLTRB(15, 0, 15, 10),
          padding: sInsetsAll(10),
          width: double.infinity,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Avatar(
                globalUserStore.bean?.avatar,
                size: 50,
              ),
              gap(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    '${globalUserStore.bean?.nickname ?? ''} ',
                                style: Font.normal,
                              ),
                              TextSpan(
                                text: ObjectUtil.isEmpty(
                                        globalUserStore.bean?.username)
                                    ? ''
                                    : '@${globalUserStore.bean.username}',
                                style: Font.minorS,
                              ),
                            ],
                          ),
                        ),
                        // Visibility(
                        //   visible: ObjectUtil.isNotEmpty(
                        //       globalUserStore.bean?.areaName),
                        //   child: Row(
                        //     children: [
                        //       Icon(
                        //         Icons.location_on,
                        //         color: CColor.hintTextColor,
                        //         size: 14,
                        //       ),
                        //       Text(
                        //         globalUserStore.bean?.areaName,
                        //         style: Font.hintXS,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    gap(height: 5),
                    Text(
                      (ObjectUtil.isEmpty(globalUserStore.bean?.disc)
                              ? '暂无简介'
                              : globalUserStore.bean?.disc) +
                          '\n',
                      style: Font.minorS,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _renderAllianceCard(MyAllianceBean item) => Container(
        margin: sInsetsLTRB(15, 10, 15, 0),
        padding: sInsetsAll(10),
        decoration: BoxDecoration(
          // color: CColor.red,
          color: CColor.lightCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: '声誉  ',
                    style: Font.minorS,
                  ),
                  TextSpan(
                    text: item.prestige.toString(),
                    style: Font.lightL,
                  ),
                ],
              ),
            ),
            gap(height: 10),
            Text(
              '我的勋章',
              style: Font.normalH,
            ),
            gap(height: 5),
            item.medal.isEmpty
                ? Center(
                    child: Text(
                      '您在该联盟暂未获得任何徽章',
                      style: Font.minor,
                    ),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: item.medal
                          .map((e) => _medalItem(e, item.medal.length))
                          .toList(),
                    ),
                  ),
          ],
        ),
      );

  Widget _medalItem(Medal medal, int count) {
    double _itemWidth = (screenWidth - sWidth(50)) / (count <= 3 ? count : 3.5);
    return SizedBox(
      width: _itemWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WebImage(
            url: medal.image,
            width: sWidth(40),
            height: sWidth(40),
          ),
          gap(height: 5),
          Text(
            medal.name,
            style: Font.normal,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        double _value = _allianceImageHeight - sHeight(35);
        if (_scrollController.offset >= _value)
          _store.setBrightness(Brightness.light);
        else if (_scrollController.offset < _value)
          _store.setBrightness(Brightness.dark);
        double opacity =
            (_scrollController.offset - _allianceImageHeight + sHeight(35))
                    .round() /
                50;
        opacity = opacity > 1 ? 1 : (opacity < 0 ? 0 : opacity);
        _store.setTitleOpacity(opacity);
      });
    _refreshController = EasyRefreshController();
  }

  @override
  void onResume() {
    _refreshController.callRefresh();
    super.onResume();
  }

  @override
  void dispose() {
    _scrollController = null;
    _refreshController = null;
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // print('didChangeDependencies');
    WidgetsBinding.instance.addPostFrameCallback(_resetHeaderHeight);
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(MinePage oldWidget) {
    // print('didUpdateWidget');
    WidgetsBinding.instance.addPostFrameCallback(_resetHeaderHeight);
    super.didUpdateWidget(oldWidget);
  }

  _resetHeaderHeight(_) {
    RenderBox _renderBox = _key.currentContext.findRenderObject();
    Offset _offset = _renderBox.localToGlobal(Offset.zero);
    sState(
      () => _headerHeight = _offset.dy + _allianceImageHeight,
    );
    // print('@@@@@@@@@@@@@' + _key.currentContext.size.height.toString());
    // print('@@@@@@@@@@@@@' + _allianceImageHeight.toString());
    // print('@@@@@@@@@@@@@' + _headerHeight.toString());
    // print('@@@@@@@@@@@@@' + _offset.dy.toString());
    // _renderBox = _tabViewKey.currentContext.findRenderObject();
    // _offset = _renderBox.localToGlobal(Offset.zero);
    // print('@@@@@@@@@@@@@' + _renderBox.size.height.toString());
  }
}
