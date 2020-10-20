// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_detail.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContentDetailStore on ContentDetailMobx, Store {
  final _$contentLineAtom = Atom(name: 'ContentDetailMobx.contentLine');

  @override
  ObservableList<dynamic> get contentLine {
    _$contentLineAtom.reportRead();
    return super.contentLine;
  }

  @override
  set contentLine(ObservableList<dynamic> value) {
    _$contentLineAtom.reportWrite(value, super.contentLine, () {
      super.contentLine = value;
    });
  }

  final _$loadErrorAtom = Atom(name: 'ContentDetailMobx.loadError');

  @override
  bool get loadError {
    _$loadErrorAtom.reportRead();
    return super.loadError;
  }

  @override
  set loadError(bool value) {
    _$loadErrorAtom.reportWrite(value, super.loadError, () {
      super.loadError = value;
    });
  }

  final _$ContentDetailMobxActionController =
      ActionController(name: 'ContentDetailMobx');

  @override
  dynamic fetchContentLine(int id) {
    final _$actionInfo = _$ContentDetailMobxActionController.startAction(
        name: 'ContentDetailMobx.fetchContentLine');
    try {
      return super.fetchContentLine(id);
    } finally {
      _$ContentDetailMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
contentLine: ${contentLine},
loadError: ${loadError}
    ''';
  }
}
