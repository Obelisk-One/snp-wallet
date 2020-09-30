/*
 * @Project:        snp
 * @Package:        ui.pages.news.store
 * @FileName:       user_list
 * @Create:         2020/9/21 7:56 PM
 * @Description:    
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'package:flustars/flustars.dart';
import 'package:mobx/mobx.dart';
import 'package:snp/beans/user_bean.dart';

part 'user_list.g.dart';

class UserListStore = UserListMobx with _$UserListStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final UserListStore userList = UserListStore();

abstract class UserListMobx with Store {
  @observable
  bool didInput = false;
  @observable
  ObservableList selected = ObservableList();
  @observable
  String searchString = '';

  @action
  void onInput(String value) {
    this.searchString = value;
    this.didInput = !ObjectUtil.isEmptyString(value);
  }

  @action
  void onItemClick(UserBean bean) {
    if (this.selected.contains(bean))
      this.selected.remove(bean);
    else
      this.selected.add(bean);
  }

  @action
  setSelected(List selected) {
    if (selected != null) {
      this.selected.clear();
      if (selected.length > 0) this.selected = selected;
    }
  }
}
