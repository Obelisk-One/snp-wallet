// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mine.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MineStore on MineMobx, Store {
  Computed<MyAllianceBean> _$currentAllianceComputed;

  @override
  MyAllianceBean get currentAlliance => (_$currentAllianceComputed ??=
          Computed<MyAllianceBean>(() => super.currentAlliance,
              name: 'MineMobx.currentAlliance'))
      .value;

  final _$brightnessAtom = Atom(name: 'MineMobx.brightness');

  @override
  Brightness get brightness {
    _$brightnessAtom.reportRead();
    return super.brightness;
  }

  @override
  set brightness(Brightness value) {
    _$brightnessAtom.reportWrite(value, super.brightness, () {
      super.brightness = value;
    });
  }

  final _$titleOpacityAtom = Atom(name: 'MineMobx.titleOpacity');

  @override
  double get titleOpacity {
    _$titleOpacityAtom.reportRead();
    return super.titleOpacity;
  }

  @override
  set titleOpacity(double value) {
    _$titleOpacityAtom.reportWrite(value, super.titleOpacity, () {
      super.titleOpacity = value;
    });
  }

  final _$myAlliancesAtom = Atom(name: 'MineMobx.myAlliances');

  @override
  ObservableList<MyAllianceBean> get myAlliances {
    _$myAlliancesAtom.reportRead();
    return super.myAlliances;
  }

  @override
  set myAlliances(ObservableList<MyAllianceBean> value) {
    _$myAlliancesAtom.reportWrite(value, super.myAlliances, () {
      super.myAlliances = value;
    });
  }

  final _$contentListAtom = Atom(name: 'MineMobx.contentList');

  @override
  ObservableList<ContentBean> get contentList {
    _$contentListAtom.reportRead();
    return super.contentList;
  }

  @override
  set contentList(ObservableList<ContentBean> value) {
    _$contentListAtom.reportWrite(value, super.contentList, () {
      super.contentList = value;
    });
  }

  final _$currentIndexAtom = Atom(name: 'MineMobx.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$pageAtom = Atom(name: 'MineMobx.page');

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

  final _$noMoreAtom = Atom(name: 'MineMobx.noMore');

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

  final _$isErrorAtom = Atom(name: 'MineMobx.isError');

  @override
  bool get isError {
    _$isErrorAtom.reportRead();
    return super.isError;
  }

  @override
  set isError(bool value) {
    _$isErrorAtom.reportWrite(value, super.isError, () {
      super.isError = value;
    });
  }

  final _$fetchMyAlliancesAsyncAction =
      AsyncAction('MineMobx.fetchMyAlliances');

  @override
  Future fetchMyAlliances() {
    return _$fetchMyAlliancesAsyncAction.run(() => super.fetchMyAlliances());
  }

  final _$fetchContentListAsyncAction =
      AsyncAction('MineMobx.fetchContentList');

  @override
  Future fetchContentList(bool refresh) {
    return _$fetchContentListAsyncAction
        .run(() => super.fetchContentList(refresh));
  }

  final _$MineMobxActionController = ActionController(name: 'MineMobx');

  @override
  void setBrightness(Brightness brightness) {
    final _$actionInfo =
        _$MineMobxActionController.startAction(name: 'MineMobx.setBrightness');
    try {
      return super.setBrightness(brightness);
    } finally {
      _$MineMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitleOpacity(double titleOpacity) {
    final _$actionInfo = _$MineMobxActionController.startAction(
        name: 'MineMobx.setTitleOpacity');
    try {
      return super.setTitleOpacity(titleOpacity);
    } finally {
      _$MineMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic switchAlliance(int index) {
    final _$actionInfo =
        _$MineMobxActionController.startAction(name: 'MineMobx.switchAlliance');
    try {
      return super.switchAlliance(index);
    } finally {
      _$MineMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
brightness: ${brightness},
titleOpacity: ${titleOpacity},
myAlliances: ${myAlliances},
contentList: ${contentList},
currentIndex: ${currentIndex},
page: ${page},
noMore: ${noMore},
isError: ${isError},
currentAlliance: ${currentAlliance}
    ''';
  }
}
