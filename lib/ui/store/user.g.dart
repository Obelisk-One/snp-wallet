// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on UserMobx, Store {
  final _$isLoginAtom = Atom(name: 'UserMobx.isLogin');

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  final _$passwordAtom = Atom(name: 'UserMobx.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$beanAtom = Atom(name: 'UserMobx.bean');

  @override
  UserBean get bean {
    _$beanAtom.reportRead();
    return super.bean;
  }

  @override
  set bean(UserBean value) {
    _$beanAtom.reportWrite(value, super.bean, () {
      super.bean = value;
    });
  }

  final _$doRegisterAsyncAction = AsyncAction('UserMobx.doRegister');

  @override
  Future doRegister(String username, String nickname) {
    return _$doRegisterAsyncAction
        .run(() => super.doRegister(username, nickname));
  }

  final _$verifyWithWordsAsyncAction = AsyncAction('UserMobx.verifyWithWords');

  @override
  Future verifyWithWords(
      {@required String words,
      SuccessCallBack onSuccess,
      ErrorCallBack onError}) {
    return _$verifyWithWordsAsyncAction.run(() => super
        .verifyWithWords(words: words, onSuccess: onSuccess, onError: onError));
  }

  final _$fetchUserInfoAsyncAction = AsyncAction('UserMobx.fetchUserInfo');

  @override
  Future fetchUserInfo() {
    return _$fetchUserInfoAsyncAction.run(() => super.fetchUserInfo());
  }

  final _$UserMobxActionController = ActionController(name: 'UserMobx');

  @override
  dynamic logout() {
    final _$actionInfo =
        _$UserMobxActionController.startAction(name: 'UserMobx.logout');
    try {
      return super.logout();
    } finally {
      _$UserMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
password: ${password},
bean: ${bean}
    ''';
  }
}
