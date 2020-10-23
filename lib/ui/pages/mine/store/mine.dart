/*
 * @Project:        snp
 * @Package:        ui.pages.mine.store
 * @FileName:       mine
 * @Create:         2020/9/2 4:55 PM
 * @Description:    
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:snp/beans/content_bean.dart';
import 'package:snp/beans/my_alliance_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/store/main_store.dart';

part 'mine.g.dart';

class MineStore = MineMobx with _$MineStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final MineStore mine = MineStore();

abstract class MineMobx with Store {
  @observable
  Brightness brightness = Brightness.dark;

  @observable
  double titleOpacity = 0;

  @observable
  ObservableList<MyAllianceBean> myAlliances = ObservableList();

  @observable
  ObservableList<ContentBean> contentList = ObservableList();

  @observable
  int currentIndex = 0;

  @observable
  int page = 1;

  @observable
  bool noMore = false;

  @observable
  bool isError = false;

  @computed
  MyAllianceBean get currentAlliance {
    if (myAlliances.isNotEmpty && myAlliances.length > currentIndex)
      return myAlliances.elementAt(currentIndex);
    return null;
  }

  @action
  void setBrightness(Brightness brightness) => this.brightness = brightness;

  @action
  void setTitleOpacity(double titleOpacity) => this.titleOpacity = titleOpacity;

  @action
  fetchMyAlliances() async {
    await http.get(
      API.myAlliances,
      onSuccess: (data) => this.myAlliances =
          ObservableList.of(getMyAllianceBeanList(data.data)),
      onError: (error) => this.myAlliances.clear(),
    );
  }

  @action
  switchAlliance(int index) {
    if (this.myAlliances.isNotEmpty && this.myAlliances.length > index) {
      this.currentIndex = index;
      fetchContentList(true);
    }
  }

  @action
  fetchContentList(bool refresh) async {
    if (currentAlliance == null) return;
    if (refresh)
      this.page = 1;
    else {
      if (this.noMore) return;
      this.page++;
    }
    this.isError = false;

    var _onError = (error) {
      this.isError = true;
      if (refresh) this.contentList.clear();
      toast(error.msg);
    };
    var response = await http.get(
      API.mineContent,
      params: {
        'league_id': currentAlliance?.leagueId,
        'page': this.page,
        'size': 5,
      },
      onError: _onError,
    );

    if ((response.code ?? 0) == 1) {
      List<ContentBean> _dataList = getContentBeanList(response.data['data']);
      if (refresh)
        this.contentList = ObservableList.of(_dataList);
      else
        this.contentList.addAll(_dataList);
      this.noMore = response.data['current_page'] >= response.data['last_page'];
    } else
      _onError(response);
  }
}
