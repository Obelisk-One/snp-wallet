// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_alliance.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateAllianceStore on CreateAllianceMobx, Store {
  final _$usersAtom = Atom(name: 'CreateAllianceMobx.users');

  @override
  ObservableList<dynamic> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<dynamic> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$CreateAllianceMobxActionController =
      ActionController(name: 'CreateAllianceMobx');

  @override
  dynamic addUser(dynamic user) {
    final _$actionInfo = _$CreateAllianceMobxActionController.startAction(
        name: 'CreateAllianceMobx.addUser');
    try {
      return super.addUser(user);
    } finally {
      _$CreateAllianceMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic deleteUser(int index) {
    final _$actionInfo = _$CreateAllianceMobxActionController.startAction(
        name: 'CreateAllianceMobx.deleteUser');
    try {
      return super.deleteUser(index);
    } finally {
      _$CreateAllianceMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
users: ${users}
    ''';
  }
}
