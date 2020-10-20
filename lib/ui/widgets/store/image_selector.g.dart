// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_selector.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageSelectorStore on ImageSelectorMobx, Store {
  Computed<bool> _$isAllUploadedComputed;

  @override
  bool get isAllUploaded =>
      (_$isAllUploadedComputed ??= Computed<bool>(() => super.isAllUploaded,
              name: 'ImageSelectorMobx.isAllUploaded'))
          .value;
  Computed<bool> _$noErrorComputed;

  @override
  bool get noError => (_$noErrorComputed ??= Computed<bool>(() => super.noError,
          name: 'ImageSelectorMobx.noError'))
      .value;
  Computed<List<String>> _$pathsComputed;

  @override
  List<String> get paths =>
      (_$pathsComputed ??= Computed<List<String>>(() => super.paths,
              name: 'ImageSelectorMobx.paths'))
          .value;
  Computed<List<String>> _$keysComputed;

  @override
  List<String> get keys =>
      (_$keysComputed ??= Computed<List<String>>(() => super.keys,
              name: 'ImageSelectorMobx.keys'))
          .value;
  Computed<List<String>> _$errorsComputed;

  @override
  List<String> get errors =>
      (_$errorsComputed ??= Computed<List<String>>(() => super.errors,
              name: 'ImageSelectorMobx.errors'))
          .value;
  Computed<List<Map<dynamic, dynamic>>> _$originalDatasComputed;

  @override
  List<Map<dynamic, dynamic>> get originalDatas => (_$originalDatasComputed ??=
          Computed<List<Map<dynamic, dynamic>>>(() => super.originalDatas,
              name: 'ImageSelectorMobx.originalDatas'))
      .value;

  final _$imgListAtom = Atom(name: 'ImageSelectorMobx.imgList');

  @override
  ObservableList<dynamic> get imgList {
    _$imgListAtom.reportRead();
    return super.imgList;
  }

  @override
  set imgList(ObservableList<dynamic> value) {
    _$imgListAtom.reportWrite(value, super.imgList, () {
      super.imgList = value;
    });
  }

  final _$ImageSelectorMobxActionController =
      ActionController(name: 'ImageSelectorMobx');

  @override
  dynamic addImage(ImageSelectorItem item) {
    final _$actionInfo = _$ImageSelectorMobxActionController.startAction(
        name: 'ImageSelectorMobx.addImage');
    try {
      return super.addImage(item);
    } finally {
      _$ImageSelectorMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteImage(ImageSelectorItem item) {
    final _$actionInfo = _$ImageSelectorMobxActionController.startAction(
        name: 'ImageSelectorMobx.deleteImage');
    try {
      return super.deleteImage(item);
    } finally {
      _$ImageSelectorMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearImage() {
    final _$actionInfo = _$ImageSelectorMobxActionController.startAction(
        name: 'ImageSelectorMobx.clearImage');
    try {
      return super.clearImage();
    } finally {
      _$ImageSelectorMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic uploadImages() {
    final _$actionInfo = _$ImageSelectorMobxActionController.startAction(
        name: 'ImageSelectorMobx.uploadImages');
    try {
      return super.uploadImages();
    } finally {
      _$ImageSelectorMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTargetDir(String dir) {
    final _$actionInfo = _$ImageSelectorMobxActionController.startAction(
        name: 'ImageSelectorMobx.setTargetDir');
    try {
      return super.setTargetDir(dir);
    } finally {
      _$ImageSelectorMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic retryUpload(ImageSelectorItem item) {
    final _$actionInfo = _$ImageSelectorMobxActionController.startAction(
        name: 'ImageSelectorMobx.retryUpload');
    try {
      return super.retryUpload(item);
    } finally {
      _$ImageSelectorMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateListItem(
      {ImageSelectorItem item,
      dynamic key,
      dynamic uploaded,
      dynamic isError}) {
    final _$actionInfo = _$ImageSelectorMobxActionController.startAction(
        name: 'ImageSelectorMobx.updateListItem');
    try {
      return super.updateListItem(
          item: item, key: key, uploaded: uploaded, isError: isError);
    } finally {
      _$ImageSelectorMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic marginList(List<dynamic> list) {
    final _$actionInfo = _$ImageSelectorMobxActionController.startAction(
        name: 'ImageSelectorMobx.marginList');
    try {
      return super.marginList(list);
    } finally {
      _$ImageSelectorMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imgList: ${imgList},
isAllUploaded: ${isAllUploaded},
noError: ${noError},
paths: ${paths},
keys: ${keys},
errors: ${errors},
originalDatas: ${originalDatas}
    ''';
  }
}
