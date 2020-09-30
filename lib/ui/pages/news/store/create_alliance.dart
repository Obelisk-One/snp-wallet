/*
 * @Project:        snp
 * @Package:        ui.pages.news.store
 * @FileName:       create_alliance
 * @Create:         2020/9/18 2:21 PM
 * @Description:    
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'package:mobx/mobx.dart';

part 'create_alliance.g.dart';

class CreateAllianceStore = CreateAllianceMobx with _$CreateAllianceStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final CreateAllianceStore createAlliance = CreateAllianceStore();

abstract class CreateAllianceMobx with Store {
  @observable
  ObservableList users = ObservableList();

  @action
  addUser(user) {
    this.users.add(user);
  }

  @action
  deleteUser(int index) {
    this.users.removeAt(index);
  }
}
