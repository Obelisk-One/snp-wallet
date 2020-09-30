// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mine.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MineStore on MineMobx, Store {
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
  String toString() {
    return '''
brightness: ${brightness},
titleOpacity: ${titleOpacity}
    ''';
  }
}
