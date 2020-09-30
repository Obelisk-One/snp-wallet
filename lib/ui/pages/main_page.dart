/*
 * 项目名:    snp
 * 包名       ui
 * 文件名:    main_page
 * 创建时间:  2020/8/25 on 5:04 PM
 * 描述:
 *
 * @author   Dino
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/pages/news/alliance_list_view.dart';
import 'package:snp/ui/pages/news/news_home_page.dart';
import 'package:snp/ui/pages/wallet/wallet_home_page.dart';
import 'package:snp/ui/store/main_store.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends BaseState<MainPage> {
//  List<Widget> _pages;
  int _lastClickTime = 0;
  MainStore _mainStore;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        key: _mainStore.scaffoldKey,
        body: Observer(
          builder: (_) => IndexedStack(
            index: _mainStore.tabIndex,
            children: _mainStore.pages,
          ),
        ),
        drawer: Container(
          width: screenWidth * 0.85,
          child: Drawer(child: AllianceListView()),
        ),
        bottomNavigationBar: _renderBottomNavigationBar(),
      ),
      onWillPop: () => _doubleExit(),
    );
  }

  @override
  void initState() {
    _mainStore = globalMainStore();
    super.initState();
  }

  @override
  void dispose() {
    _mainStore = null;
    super.dispose();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  void didUpdateWidget(MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _renderBottomNavigationBar() => Observer(
        builder: (_) => BottomNavigationBar(
          elevation: 8.0,
          backgroundColor: CColor.bgColor,
          currentIndex: _mainStore.tabIndex,
          onTap: (index) => _mainStore.switchTo(index),
          type: BottomNavigationBarType.fixed,
          //fixedColor: Colors.white,
          items: [
            _renderBottomItem(
              '动态',
              SnpIcon.tab_news,
              SnpIcon.tab_news_on,
            ),
            _renderBottomItem(
              '管理台',
              SnpIcon.tab_board,
              SnpIcon.tab_board_on,
            ),
            _renderBottomItem(
              '口袋',
              SnpIcon.tab_wallet,
              SnpIcon.tab_wallet_on,
            ),
            _renderBottomItem(
              '我的',
              SnpIcon.tab_mine,
              SnpIcon.tab_mine_on,
            ),
          ],
        ),
      );

  _renderBottomItem(text, icon, activeIcon, {num = 0}) =>
      BottomNavigationBarItem(
        label: text,
        backgroundColor: CColor.bgColor,
        activeIcon: Icon(
          activeIcon,
          color: CColor.mainColor,
        ),
        icon: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Icon(
                icon,
                color: CColor.textColor,
              ),
            ),
            Visibility(
              visible: num > 0,
              child: Positioned(
                  right: 0,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 9.0,
                      ),
                      Text(
                        '99+',
                        style: ts(s: 10, c: Colors.white),
                      )
                    ],
                  )),
            ),
          ],
        ),
      );

  Future<bool> _doubleExit() {
    int nowTime = DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return Future.value(true);
    } else {
      _lastClickTime = DateTime.now().microsecondsSinceEpoch;
      Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
      toast('再次返回退出');
      return Future.value(false);
    }
  }
}
