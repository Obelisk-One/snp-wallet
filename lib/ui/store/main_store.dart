/*
 * @Project:        snp
 * @Package:        ui.store
 * @FileName:       main_page_store
 * @Create:         2020/8/27 4:03 PM
 * @Description:    主页Store
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:snp/common/base/base_config.dart';
import 'package:snp/main.dart';
import 'package:snp/ui/pages/board/board_home_page.dart';
import 'package:snp/ui/pages/mine/mine_page.dart';
import 'package:snp/ui/pages/news/news_home_page.dart';
import 'package:snp/ui/pages/wallet/wallet_home_page.dart';

part 'main_store.g.dart';

class MainStore = MainStoreMobx with _$MainStore;

//全局Store对象,所有页面共用,需要的话取消注释
// final MainStore mainPageStore = MainStore();

abstract class MainStoreMobx with Store {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  int tabIndex = 0;

  @observable
  int allianceId = -1;

  // @computed
  // int get selectedAllianceId {
  //   if (allianceId == -1)
  //     allianceId = SpUtil.getInt(
  //       Config.sp_key_alliance_id,
  //       defValue: -1,
  //     );
  //   return allianceId;
  // }

  @observable
  ObservableList<Widget> pages = ObservableList.of(
    [
      NewsHomePage(),
      Container(),
      Container(),
      Container(),
    ],
  );

  @action
  void openDrawer() {
    if (this.tabIndex == 0) scaffoldKey.currentState.openDrawer();
  }

  @action
  void endDrawer() {
    if (this.tabIndex == 0) scaffoldKey.currentState.openEndDrawer();
  }

  @action
  switchTo(int index) {
    if (index >= this.pages.length) return;
    if (this.pages[index] is Container) {
      switch (index) {
        case 1:
          this.pages[index] = BoardHomePage();
          break;
        case 2:
          this.pages[index] = WalletHomePage();
          break;
        case 3:
          this.pages[index] = MinePage();
          break;
      }
    }
    this.tabIndex = index;
  }

  @action
  setAllianceId(int id) {
    SpUtil.putInt(Config.sp_key_alliance_id, id);
    allianceId = id;
  }
}

MainStore globalMainStore() {
  return Provider.of<MainStore>(rootKey.currentContext, listen: false);
}
