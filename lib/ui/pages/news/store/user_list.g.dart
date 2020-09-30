// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_list.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserListStore on UserListMobx, Store {
  final _$didInputAtom = Atom(name: 'UserListMobx.didInput');

  @override
  bool get didInput {
    _$didInputAtom.reportRead();
    return super.didInput;
  }

  @override
  set didInput(bool value) {
    _$didInputAtom.reportWrite(value, super.didInput, () {
      super.didInput = value;
    });
  }

  final _$selectedAtom = Atom(name: 'UserListMobx.selected');

  @override
  ObservableList<dynamic> get selected {
    _$selectedAtom.reportRead();
    return super.selected;
  }

  @override
  set selected(ObservableList<dynamic> value) {
    _$selectedAtom.reportWrite(value, super.selected, () {
      super.selected = value;
    });
  }

  final _$searchStringAtom = Atom(name: 'UserListMobx.searchString');

  @override
  String get searchString {
    _$searchStringAtom.reportRead();
    return super.searchString;
  }

  @override
  set searchString(String value) {
    _$searchStringAtom.reportWrite(value, super.searchString, () {
      super.searchString = value;
    });
  }

  final _$UserListMobxActionController = ActionController(name: 'UserListMobx');

  @override
  void onInput(String value) {
    final _$actionInfo = _$UserListMobxActionController.startAction(
        name: 'UserListMobx.onInput');
    try {
      return super.onInput(value);
    } finally {
      _$UserListMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onItemClick(UserBean bean) {
    final _$actionInfo = _$UserListMobxActionController.startAction(
        name: 'UserListMobx.onItemClick');
    try {
      return super.onItemClick(bean);
    } finally {
      _$UserListMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setSelected(List<dynamic> selected) {
    final _$actionInfo = _$UserListMobxActionController.startAction(
        name: 'UserListMobx.setSelected');
    try {
      return super.setSelected(selected);
    } finally {
      _$UserListMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
didInput: ${didInput},
selected: ${selected},
searchString: ${searchString}
    ''';
  }
}
