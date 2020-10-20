// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_home.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BoardHomeStore on BoardHomeMobx, Store {
  final _$brightnessAtom = Atom(name: 'BoardHomeMobx.brightness');

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

  final _$titleOpacityAtom = Atom(name: 'BoardHomeMobx.titleOpacity');

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

  final _$fameDataAtom = Atom(name: 'BoardHomeMobx.fameData');

  @override
  ObservableMap<String, dynamic> get fameData {
    _$fameDataAtom.reportRead();
    return super.fameData;
  }

  @override
  set fameData(ObservableMap<String, dynamic> value) {
    _$fameDataAtom.reportWrite(value, super.fameData, () {
      super.fameData = value;
    });
  }

  final _$fecDataAtom = Atom(name: 'BoardHomeMobx.fecData');

  @override
  ObservableMap<String, dynamic> get fecData {
    _$fecDataAtom.reportRead();
    return super.fecData;
  }

  @override
  set fecData(ObservableMap<String, dynamic> value) {
    _$fecDataAtom.reportWrite(value, super.fecData, () {
      super.fecData = value;
    });
  }

  final _$allianceInfoAtom = Atom(name: 'BoardHomeMobx.allianceInfo');

  @override
  AllianceInfoBean get allianceInfo {
    _$allianceInfoAtom.reportRead();
    return super.allianceInfo;
  }

  @override
  set allianceInfo(AllianceInfoBean value) {
    _$allianceInfoAtom.reportWrite(value, super.allianceInfo, () {
      super.allianceInfo = value;
    });
  }

  final _$applyListAtom = Atom(name: 'BoardHomeMobx.applyList');

  @override
  ObservableList<AllianceApplyBean> get applyList {
    _$applyListAtom.reportRead();
    return super.applyList;
  }

  @override
  set applyList(ObservableList<AllianceApplyBean> value) {
    _$applyListAtom.reportWrite(value, super.applyList, () {
      super.applyList = value;
    });
  }

  final _$pageAtom = Atom(name: 'BoardHomeMobx.page');

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

  final _$noMoreAtom = Atom(name: 'BoardHomeMobx.noMore');

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

  final _$isErrorAtom = Atom(name: 'BoardHomeMobx.isError');

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

  final _$stakeListAtom = Atom(name: 'BoardHomeMobx.stakeList');

  @override
  ObservableList<AllianceStakeBean> get stakeList {
    _$stakeListAtom.reportRead();
    return super.stakeList;
  }

  @override
  set stakeList(ObservableList<AllianceStakeBean> value) {
    _$stakeListAtom.reportWrite(value, super.stakeList, () {
      super.stakeList = value;
    });
  }

  final _$fetchStakeErrorAtom = Atom(name: 'BoardHomeMobx.fetchStakeError');

  @override
  bool get fetchStakeError {
    _$fetchStakeErrorAtom.reportRead();
    return super.fetchStakeError;
  }

  @override
  set fetchStakeError(bool value) {
    _$fetchStakeErrorAtom.reportWrite(value, super.fetchStakeError, () {
      super.fetchStakeError = value;
    });
  }

  final _$myCapacityAtom = Atom(name: 'BoardHomeMobx.myCapacity');

  @override
  int get myCapacity {
    _$myCapacityAtom.reportRead();
    return super.myCapacity;
  }

  @override
  set myCapacity(int value) {
    _$myCapacityAtom.reportWrite(value, super.myCapacity, () {
      super.myCapacity = value;
    });
  }

  final _$fetchAllianceInfoAsyncAction =
      AsyncAction('BoardHomeMobx.fetchAllianceInfo');

  @override
  Future fetchAllianceInfo() {
    return _$fetchAllianceInfoAsyncAction.run(() => super.fetchAllianceInfo());
  }

  final _$fetchAllianceApplyAsyncAction =
      AsyncAction('BoardHomeMobx.fetchAllianceApply');

  @override
  Future fetchAllianceApply(bool refresh) {
    return _$fetchAllianceApplyAsyncAction
        .run(() => super.fetchAllianceApply(refresh));
  }

  final _$fetchAllianceStakeAsyncAction =
      AsyncAction('BoardHomeMobx.fetchAllianceStake');

  @override
  Future fetchAllianceStake() {
    return _$fetchAllianceStakeAsyncAction
        .run(() => super.fetchAllianceStake());
  }

  final _$fetchMyCapacityAsyncAction =
      AsyncAction('BoardHomeMobx.fetchMyCapacity');

  @override
  Future fetchMyCapacity() {
    return _$fetchMyCapacityAsyncAction.run(() => super.fetchMyCapacity());
  }

  final _$doStakeAsyncAction = AsyncAction('BoardHomeMobx.doStake');

  @override
  Future doStake(int value, int userId) {
    return _$doStakeAsyncAction.run(() => super.doStake(value, userId));
  }

  final _$BoardHomeMobxActionController =
      ActionController(name: 'BoardHomeMobx');

  @override
  void setBrightness(Brightness brightness) {
    final _$actionInfo = _$BoardHomeMobxActionController.startAction(
        name: 'BoardHomeMobx.setBrightness');
    try {
      return super.setBrightness(brightness);
    } finally {
      _$BoardHomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitleOpacity(double titleOpacity) {
    final _$actionInfo = _$BoardHomeMobxActionController.startAction(
        name: 'BoardHomeMobx.setTitleOpacity');
    try {
      return super.setTitleOpacity(titleOpacity);
    } finally {
      _$BoardHomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFameData(Map<String, dynamic> fameData) {
    final _$actionInfo = _$BoardHomeMobxActionController.startAction(
        name: 'BoardHomeMobx.setFameData');
    try {
      return super.setFameData(fameData);
    } finally {
      _$BoardHomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFecData(Map<String, dynamic> fecData) {
    final _$actionInfo = _$BoardHomeMobxActionController.startAction(
        name: 'BoardHomeMobx.setFecData');
    try {
      return super.setFecData(fecData);
    } finally {
      _$BoardHomeMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
brightness: ${brightness},
titleOpacity: ${titleOpacity},
fameData: ${fameData},
fecData: ${fecData},
allianceInfo: ${allianceInfo},
applyList: ${applyList},
page: ${page},
noMore: ${noMore},
isError: ${isError},
stakeList: ${stakeList},
fetchStakeError: ${fetchStakeError},
myCapacity: ${myCapacity}
    ''';
  }
}
