/*
 * @Project:        snp
 * @Package:        ui.pages.news.store
 * @FileName:       content_detail
 * @Create:         2020/10/20 6:14 PM
 * @Description:    
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'package:mobx/mobx.dart';
import 'package:snp/apis.dart';
import 'package:snp/beans/content_bean.dart';
import 'package:snp/common/utils/http_util.dart';

part 'content_detail.g.dart';

class ContentDetailStore = ContentDetailMobx with _$ContentDetailStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final ContentDetailStore contentDetail = ContentDetailStore();

abstract class ContentDetailMobx with Store {
  @observable
  ObservableList contentLine = ObservableList();

  @observable
  bool loadError = false;

  @action
  fetchContentLine(int id) {
    http.get(
      API.contentLine,
      params: <String, dynamic>{'dynamic_id': id},
      onSuccess: (data) {
        this.contentLine = ObservableList.of(getContentBeanList(data.data));
        this.loadError = false;
      },
      onError: (error) {
        this.contentLine.clear();
        this.loadError = true;
      },
    );
  }
}
