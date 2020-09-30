/*
 * @Project:        snp
 * @Package:        ui.pages.mine.store
 * @FileName:       settings
 * @Create:         2020/9/3 6:21 PM
 * @Description:    
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/ui_util.dart';

part 'settings.g.dart';

class SettingsStore = SettingsMobx with _$SettingsStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final SettingsStore settings = SettingsStore();

abstract class SettingsMobx with Store {
  @observable
  String version;

  @observable
  String tempSize;

  bool isEmpty = false;

  @action
  void getVersion() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      this.version = packageInfo.version;
    });
  }

  @action
  Future<void> getTempSize() async {
    this.tempSize = await _loadCache();
  }

  @action
  void emptyTemp(BuildContext context) {
    if (isEmpty) {
      toast('不需要清理');
      return;
    }
    afterLoading(
      getTemporaryDirectory().then((value) => _deleteDir(value)),
    ).then((value) async {
      if (value == null) {
        this.tempSize = await _loadCache();
        toast('缓存已清理~');
      } else
        toast('清理缓存失败~');
    });
  }

  Future<String> _loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    isEmpty = value <= 0;
    /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //打印每个缓存文件的路径
        print(file.path);
      });*/
//    print('临时目录大小: ' + value.toString());
    return _renderSize(value);
  }

  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory && file.existsSync()) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  String _renderSize(double value) {
    if (null == value || NumUtil.isZero(value)) {
      return '0 K';
    }
    List<String> unitArr = List()..add(' B')..add(' K')..add(' M')..add(' G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  Future<Null> _deleteDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _deleteDir(child);
      }
    }
    await file.delete();
  }
}
