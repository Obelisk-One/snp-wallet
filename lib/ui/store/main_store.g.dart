// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainStore on MainStoreMobx, Store {
  final _$tabIndexAtom = Atom(name: 'MainStoreMobx.tabIndex');

  @override
  int get tabIndex {
    _$tabIndexAtom.reportRead();
    return super.tabIndex;
  }

  @override
  set tabIndex(int value) {
    _$tabIndexAtom.reportWrite(value, super.tabIndex, () {
      super.tabIndex = value;
    });
  }

  final _$allianceIdAtom = Atom(name: 'MainStoreMobx.allianceId');

  @override
  int get allianceId {
    _$allianceIdAtom.reportRead();
    return super.allianceId;
  }

  @override
  set allianceId(int value) {
    _$allianceIdAtom.reportWrite(value, super.allianceId, () {
      super.allianceId = value;
    });
  }

  final _$isInAllianceAtom = Atom(name: 'MainStoreMobx.isInAlliance');

  @override
  bool get isInAlliance {
    _$isInAllianceAtom.reportRead();
    return super.isInAlliance;
  }

  @override
  set isInAlliance(bool value) {
    _$isInAllianceAtom.reportWrite(value, super.isInAlliance, () {
      super.isInAlliance = value;
    });
  }

  final _$pagesAtom = Atom(name: 'MainStoreMobx.pages');

  @override
  ObservableList<Widget> get pages {
    _$pagesAtom.reportRead();
    return super.pages;
  }

  @override
  set pages(ObservableList<Widget> value) {
    _$pagesAtom.reportWrite(value, super.pages, () {
      super.pages = value;
    });
  }

  final _$setAllianceIdAsyncAction = AsyncAction('MainStoreMobx.setAllianceId');

  @override
  Future setAllianceId(int id) {
    return _$setAllianceIdAsyncAction.run(() => super.setAllianceId(id));
  }

  final _$checkIsInAllianceAsyncAction =
      AsyncAction('MainStoreMobx.checkIsInAlliance');

  @override
  Future checkIsInAlliance() {
    return _$checkIsInAllianceAsyncAction.run(() => super.checkIsInAlliance());
  }

  final _$MainStoreMobxActionController =
      ActionController(name: 'MainStoreMobx');

  @override
  void openDrawer() {
    final _$actionInfo = _$MainStoreMobxActionController.startAction(
        name: 'MainStoreMobx.openDrawer');
    try {
      return super.openDrawer();
    } finally {
      _$MainStoreMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void endDrawer() {
    final _$actionInfo = _$MainStoreMobxActionController.startAction(
        name: 'MainStoreMobx.endDrawer');
    try {
      return super.endDrawer();
    } finally {
      _$MainStoreMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic switchTo(int index) {
    final _$actionInfo = _$MainStoreMobxActionController.startAction(
        name: 'MainStoreMobx.switchTo');
    try {
      return super.switchTo(index);
    } finally {
      _$MainStoreMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabIndex: ${tabIndex},
allianceId: ${allianceId},
isInAlliance: ${isInAlliance},
pages: ${pages}
    ''';
  }
}
