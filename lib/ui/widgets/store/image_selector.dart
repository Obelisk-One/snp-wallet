/*
 * @Project:        snp
 * @Package:        ui.widgets.store
 * @FileName:       image_selector
 * @Create:         2020/9/18 4:30 PM
 * @Description:    
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'package:mobx/mobx.dart';
import 'package:snp/common/base/base_config.dart';
import 'package:snp/common/utils/oss_util.dart';
import 'package:snp/common/utils/ui_util.dart';

part 'image_selector.g.dart';

class ImageSelectorStore = ImageSelectorMobx with _$ImageSelectorStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final ImageSelectorStore imageSelector = ImageSelectorStore();

abstract class ImageSelectorMobx with Store {
  @observable
  ObservableList imgList = ObservableList();

  Function uploadDone;

  String _targetDir = Config.oss_remote_dir_apply;

  @action
  addImage(ImageSelectorItem item) => this.imgList.add(item);

  @action
  deleteImage(ImageSelectorItem item) {
    if (item.key.isNotEmpty && item.uploaded) oss.deleteImage(item.key);
    this.imgList.remove(item);
  }

  @action
  clearImage() => this.imgList.clear();

  @action
  uploadImages() {
    if (this.imgList.length > 0 && !isAllUploaded)
      _doUpload(this.imgList[0]);
    else if (uploadDone != null) uploadDone();
  }

  @action
  setTargetDir(String dir){
    this._targetDir=dir;
  }

  _doUpload(ImageSelectorItem item) {
    final _next = () {
      int _index = this.imgList.indexOf(item) + 1;
      if (_index < this.imgList.length)
        _doUpload(this.imgList[_index]);
      else if (uploadDone != null) uploadDone();
    };
    if (item.path.isNotEmpty && !item.uploaded) {
      oss.uploadImage(
        item.path,
        _targetDir,
        onFinish: (success, key, msg) {
          this.updateListItem(
            item: item,
            key: success ? key : '',
            uploaded: success,
            isError: !success,
          );
          if (!success) toast(msg);
          print(msg);
          _next();
        },
      );
    } else
      _next();
  }

  @action
  retryUpload(ImageSelectorItem item) {
    showLoading();
    this.updateListItem(item: item, isError: false);
    oss.uploadImage(
      item.path,
      _targetDir,
      onFinish: (success, key, msg) {
        dismissLoading();
        if (success) {
          this.updateListItem(
            item: item,
            key: key,
            uploaded: true,
            isError: false,
          );
          // if (uploadDone != null) uploadDone();
        } else {
          this.updateListItem(item: item, isError: true);
        }
      },
    );
  }

  @action
  updateListItem({ImageSelectorItem item, key, uploaded, isError}) {
    int index = this.imgList.indexOf(item);
    item.key = key == null ? item.key : key;
    item.uploaded = uploaded == null ? item.uploaded : uploaded;
    item.isError = isError == null ? item.isError : isError;

    this.imgList.replaceRange(index, index + 1, [item]);
  }

  @action
  marginList(List list) {
    List _newList = [];
    list.forEach((newItem) {
      if (this.imgList.any((e) => e.id == newItem['id'].toString())) {
        final oldItem =
            this.imgList.firstWhere((e) => e.id == newItem['id'].toString());
        _newList.add(oldItem);
      } else {
        _newList.add(ImageSelectorItem(
          newItem,
          newItem['id'].toString(),
          newItem['path'],
        ));
      }
    });
    this.imgList = ObservableList.of(_newList);
  }

  @computed
  bool get isAllUploaded => this.imgList.every((e) => e.uploaded);

  @computed
  bool get noError => this.imgList.every((e) => !e.isError);

  @computed
  List<String> get paths {
    List<String> _list = [];
    this.imgList.forEach((e) => _list.add(e.path));
    return _list;
  }

  @computed
  List<String> get keys {
    List<String> _list = [];
    this.imgList.forEach((e) => _list.add(e.key));
    return _list;
  }

  @computed
  List<String> get errors {
    List<String> _list = [];
    this.imgList.forEach((e) {
      if (e.isError) _list.add(e.path);
    });
    return _list;
  }

  @computed
  List<Map> get originalDatas {
    List<Map> _list = [];
    this.imgList.forEach((e) => _list.add(e.originalData));
    return _list;
  }
}

class ImageSelectorItem {
  /// 唯一标识
  String id;

  /// 本地路径
  String path;

  /// 上传后的key
  String key;

  /// 是否已经上传
  bool uploaded;

  /// 是否上传失败
  bool isError;

  /// 选择照片的原始数据
  Map originalData;

  ImageSelectorItem(
    this.originalData,
    this.id,
    this.path, {
    this.key = '',
    this.uploaded = false,
    this.isError = false,
  });
}
