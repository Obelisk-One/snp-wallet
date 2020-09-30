// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_view.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListViewStore on ListViewMobx, Store {
  final _$countAtom = Atom(name: 'ListViewMobx.count');

  @override
  int get count {
    _$countAtom.reportRead();
    return super.count;
  }

  @override
  set count(int value) {
    _$countAtom.reportWrite(value, super.count, () {
      super.count = value;
    });
  }

  final _$pageAtom = Atom(name: 'ListViewMobx.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'ListViewMobx.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$noMoreAtom = Atom(name: 'ListViewMobx.noMore');

  @override
  bool get noMore {
    _$noMoreAtom.reportRead();
    return super.noMore;
  }

  @override
  set noMore(bool value) {
    _$noMoreAtom.reportWrite(value, super.noMore, () {
      super.noMore = value;
    });
  }

  final _$refreshErrorAtom = Atom(name: 'ListViewMobx.refreshError');

  @override
  bool get refreshError {
    _$refreshErrorAtom.reportRead();
    return super.refreshError;
  }

  @override
  set refreshError(bool value) {
    _$refreshErrorAtom.reportWrite(value, super.refreshError, () {
      super.refreshError = value;
    });
  }

  final _$loadMoreErrorAtom = Atom(name: 'ListViewMobx.loadMoreError');

  @override
  bool get loadMoreError {
    _$loadMoreErrorAtom.reportRead();
    return super.loadMoreError;
  }

  @override
  set loadMoreError(bool value) {
    _$loadMoreErrorAtom.reportWrite(value, super.loadMoreError, () {
      super.loadMoreError = value;
    });
  }

  final _$errorDataAtom = Atom(name: 'ListViewMobx.errorData');

  @override
  ResultData get errorData {
    _$errorDataAtom.reportRead();
    return super.errorData;
  }

  @override
  set errorData(ResultData value) {
    _$errorDataAtom.reportWrite(value, super.errorData, () {
      super.errorData = value;
    });
  }

  final _$emptyViewAtom = Atom(name: 'ListViewMobx.emptyView');

  @override
  Widget get emptyView {
    _$emptyViewAtom.reportRead();
    return super.emptyView;
  }

  @override
  set emptyView(Widget value) {
    _$emptyViewAtom.reportWrite(value, super.emptyView, () {
      super.emptyView = value;
    });
  }

  final _$dataListAtom = Atom(name: 'ListViewMobx.dataList');

  @override
  ObservableList<dynamic> get dataList {
    _$dataListAtom.reportRead();
    return super.dataList;
  }

  @override
  set dataList(ObservableList<dynamic> value) {
    _$dataListAtom.reportWrite(value, super.dataList, () {
      super.dataList = value;
    });
  }

  final _$ListViewMobxActionController = ActionController(name: 'ListViewMobx');

  @override
  void setApiPath(String apiPath) {
    final _$actionInfo = _$ListViewMobxActionController.startAction(
        name: 'ListViewMobx.setApiPath');
    try {
      return super.setApiPath(apiPath);
    } finally {
      _$ListViewMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setParams(Map<String, dynamic> params) {
    final _$actionInfo = _$ListViewMobxActionController.startAction(
        name: 'ListViewMobx.setParams');
    try {
      return super.setParams(params);
    } finally {
      _$ListViewMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMethod(String method) {
    final _$actionInfo = _$ListViewMobxActionController.startAction(
        name: 'ListViewMobx.setMethod');
    try {
      return super.setMethod(method);
    } finally {
      _$ListViewMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setController(EasyRefreshController controller) {
    final _$actionInfo = _$ListViewMobxActionController.startAction(
        name: 'ListViewMobx.setController');
    try {
      return super.setController(controller);
    } finally {
      _$ListViewMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
count: ${count},
page: ${page},
isLoading: ${isLoading},
noMore: ${noMore},
refreshError: ${refreshError},
loadMoreError: ${loadMoreError},
errorData: ${errorData},
emptyView: ${emptyView},
dataList: ${dataList}
    ''';
  }
}
