/*
 * @Project:        snp
 * @Package:        ui.store
 * @FileName:       list_view_store
 * @Create:         2020/8/27 8:06 PM
 * @Description:    通用列表Store
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:snp/beans/list_data_bean.dart';
import 'package:snp/common/base/base_config.dart';
import 'package:snp/common/utils/http_util.dart';
import 'package:snp/ui/widgets/empty_list_view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

part 'list_view.g.dart';

class ListViewStore = ListViewMobx with _$ListViewStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final ListViewStore listViewStore = ListViewStore();

abstract class ListViewMobx with Store {
  @observable
  int count = 0;

  @observable
  int page = 1;

  @observable
  bool isLoading = false;

  @observable
  bool noMore = false;

  @observable
  bool refreshError = false;

  @observable
  bool loadMoreError = false;

  @observable
  ResultData errorData;

  @observable
  Widget emptyView = EmptyListView();

  @observable
  ObservableList dataList = ObservableList();

  String apiPath = '';
  String method = 'GET';
  bool isLoadingMore = false;
  Map<String, dynamic> params = new Map();
  Map<String, dynamic> _params = new Map();
  EasyRefreshController controller;

  @action
  void setApiPath(String apiPath) {
    this.apiPath = apiPath;
  }

  @action
  void setParams(Map<String, dynamic> params) {
    this.params = params;
  }

  @action
  void setMethod(String method) {
    this.method = method;
  }

  @action
  void setController(EasyRefreshController controller) {
    this.controller = controller;
  }

  _initParams() {
    if (this.params != null) {
      _params = Map.from(this.params);
    }
    _params['page'] = this.page;
    _params['size'] = Config.listPageSize;
  }

  Future<Null> refresh() async {
    this.isLoadingMore = false;
    this.page = 1;
    List _newEntries = await _doHttpRequest();
    this.dataList.clear();
    this.dataList.addAll(_newEntries);
    // this.dataList.replaceRange(0, count, _newEntries);
    this.count = this.dataList.length + (this.noMore ? 1 : 0);
  }

  Future<Null> loadMore() async {
    if (!this.noMore) {
      this.isLoadingMore = true;
      this.page++;
      List _newEntries = await _doHttpRequest();
      this.dataList.addAll(_newEntries);
      this.count =
          this.dataList.length + (this.noMore || this.loadMoreError ? 1 : 0);
      if (this.noMore || this.loadMoreError)
        this.controller.finishLoadCallBack(noMore: true);
    }
  }

  Future<List> _doHttpRequest() async {
    this.isLoading = true;

    _initParams();
    var response;
    dynamic result = List();

    try {
      switch (this.method.toUpperCase()) {
        case 'POST':
          response = await HttpUtil.getInstance().post(
            this.apiPath,
            params: _params,
            onError: _requestError,
          );
          break;
        case 'GET':
          response = await HttpUtil.getInstance().get(
            this.apiPath,
            params: _params,
            onError: _requestError,
          );
          break;
      }
      if (response is ResultData && response.error) return result;
    } catch (e) {
      // _requestError();
      return result;
    }

    int code = response.code ?? 0;
    if (code == 1) {
      ListData listData = ListData.fromJson(response.data);
      this.noMore = listData.currentPage >= listData.lastPage;
      this.controller.finishLoadCallBack(noMore: this.noMore);
      this.loadMoreError = false;
      this.refreshError = false;
      result = listData.data;
    } else {
      _requestError(response);
    }
    this.isLoading = false;
    return result;
  }

  void _requestError(ResultData data) {
    this.errorData = data;
    this.isLoading = false;
    if (this.isLoadingMore)
      this.loadMoreError = true;
    else {
      this.dataList.clear();
      this.refreshError = true;
    }
  }

  void clearController() {
    this.controller = null;
  }
}
