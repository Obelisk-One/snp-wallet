// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on SettingsMobx, Store {
  final _$versionAtom = Atom(name: 'SettingsMobx.version');

  @override
  String get version {
    _$versionAtom.reportRead();
    return super.version;
  }

  @override
  set version(String value) {
    _$versionAtom.reportWrite(value, super.version, () {
      super.version = value;
    });
  }

  final _$tempSizeAtom = Atom(name: 'SettingsMobx.tempSize');

  @override
  String get tempSize {
    _$tempSizeAtom.reportRead();
    return super.tempSize;
  }

  @override
  set tempSize(String value) {
    _$tempSizeAtom.reportWrite(value, super.tempSize, () {
      super.tempSize = value;
    });
  }

  final _$getTempSizeAsyncAction = AsyncAction('SettingsMobx.getTempSize');

  @override
  Future<void> getTempSize() {
    return _$getTempSizeAsyncAction.run(() => super.getTempSize());
  }

  final _$SettingsMobxActionController = ActionController(name: 'SettingsMobx');

  @override
  void getVersion() {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.getVersion');
    try {
      return super.getVersion();
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void emptyTemp(BuildContext context) {
    final _$actionInfo = _$SettingsMobxActionController.startAction(
        name: 'SettingsMobx.emptyTemp');
    try {
      return super.emptyTemp(context);
    } finally {
      _$SettingsMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
version: ${version},
tempSize: ${tempSize}
    ''';
  }
}
