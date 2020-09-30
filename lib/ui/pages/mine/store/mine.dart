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

part 'mine.g.dart';

class MineStore = MineMobx with _$MineStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final MineStore mine = MineStore();

abstract class MineMobx with Store {
  @observable
  Brightness brightness = Brightness.dark;

  @observable
  double titleOpacity = 0;

  @action
  void setBrightness(Brightness brightness) => this.brightness = brightness;

  @action
  void setTitleOpacity(double titleOpacity) => this.titleOpacity = titleOpacity;

}