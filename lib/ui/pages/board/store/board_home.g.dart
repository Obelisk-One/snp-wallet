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

  final _$fetchAllianceApplyAsyncAction =
      AsyncAction('BoardHomeMobx.fetchAllianceApply');

  @override
  Future fetchAllianceApply() {
    return _$fetchAllianceApplyAsyncAction
        .run(() => super.fetchAllianceApply());
  }

  final _$fetchAllianceStimulateAsyncAction =
      AsyncAction('BoardHomeMobx.fetchAllianceStimulate');

  @override
  Future fetchAllianceStimulate() {
    return _$fetchAllianceStimulateAsyncAction
        .run(() => super.fetchAllianceStimulate());
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
fecData: ${fecData}
    ''';
  }
}
