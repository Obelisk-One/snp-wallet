/*
 * @Project:        snp
 * @Package:        ui.store
 * @FileName:       board_home_store
 * @Create:         2020/8/31 6:36 PM
 * @Description:    
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:snp/apis.dart';
import 'package:snp/beans/alliance_apply_bean.dart';
import 'package:snp/beans/alliance_info_bean.dart';
import 'package:snp/common/base/base_color.dart';
import 'package:snp/common/base/base_config.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/http_util.dart';
import 'package:snp/ui/store/main_store.dart';

part 'board_home.g.dart';

class BoardHomeStore = BoardHomeMobx with _$BoardHomeStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final BoardHome boardHome = BoardHome();

abstract class BoardHomeMobx with Store {
  @observable
  Brightness brightness = Brightness.dark;

  @observable
  double titleOpacity = 0;

  @observable
  ObservableMap<String, dynamic> fameData = ObservableMap.of({
    '张三': {
      'value': 150.0,
      'percentage': 15.0,
      'color': CColor.blue,
    },
    '李四': {
      'value': 300.0,
      'percentage': 30.0,
      'color': CColor.green,
    },
    '王五': {
      'value': 450.0,
      'percentage': 45.0,
      'color': CColor.red,
    },
    '其他': {
      'value': 100.0,
      'percentage': 10.0,
      'color': CColor.orange,
    },
  });

  @observable
  ObservableMap<String, dynamic> fecData = ObservableMap.of({
    '张三': {
      'value': 250.0,
      'percentage': 25.0,
      'color': CColor.blue,
    },
    '李四': {
      'value': 200.0,
      'percentage': 20.0,
      'color': CColor.green,
    },
    '王五': {
      'value': 150.0,
      'percentage': 15.0,
      'color': CColor.red,
    },
    '其他': {
      'value': 400.0,
      'percentage': 40.0,
      'color': CColor.orange,
    },
  });

  @observable
  AllianceInfoBean allianceInfo;

  @observable
  ObservableList applyList = ObservableList();

  @observable
  int page = 1;

  @observable
  bool noMore = false;

  @observable
  bool isError = false;

  @action
  void setBrightness(Brightness brightness) => this.brightness = brightness;

  @action
  void setTitleOpacity(double titleOpacity) => this.titleOpacity = titleOpacity;

  @action
  void setFameData(Map<String, dynamic> fameData) =>
      this.fameData = ObservableMap.of(fameData);

  @action
  void setFecData(Map<String, dynamic> fecData) =>
      this.fecData = ObservableMap.of(fecData);

  @action
  fetchAllianceInfo() async {
    await http.get(
      API.allianceInfo,
      params: {'league_id': globalMainStore.allianceId},
      onSuccess: (data) => allianceInfo = AllianceInfoBean.fromJson(data.data),
      onError: (error) => allianceInfo = null,
    );
  }

  @action
  fetchAllianceApply(bool refresh) async {
    if (refresh)
      this.page = 1;
    else {
      if (this.noMore) return;
      this.page++;
    }
    this.isError = false;

    var _onError = (error) {
      this.isError = true;
      if (refresh) this.applyList.clear();
      toast(error.msg);
    };
    var response = await http.get(
      API.allianceApply,
      params: _initParams(),
      onError: _onError,
    );

    if ((response.code ?? 0) == 1) {
      List _dataList = getAllianceApplyBeanList(response.data['data']);
      if (refresh)
        this.applyList = ObservableList.of(_dataList);
      else
        this.applyList.addAll(_dataList);
      this.noMore = response.data['current_page'] >= response.data['last_page'];
    } else {
      _onError(response);
    }
  }

  _initParams() {
    Map<String, dynamic> _params = Map<String, dynamic>();
    _params['league_id'] = globalMainStore.allianceId;
    _params['page'] = this.page;
    _params['size'] = Config.listPageSize;
    return _params;
  }

  @action
  fetchAllianceStimulate() async {
    // await http.get(
    //   API.allianceStimulate,
    //   params: {
    //     'league_id': globalMainStore().allianceId,
    //   },
    // );
  }
}
