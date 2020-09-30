/*
 * 项目名:    snp
 * 包名       base
 * 文件名:    base_stateful_widget
 * 创建时间:  2020/8/25 on 4:37 PM
 * 描述:     
 *
 * @author   Dino
 */
import 'package:flutter/material.dart';
import 'package:snp/common/utils/route_util.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  bool canPop() {
    return RouteUtil.canPop(context);
  }

  void pushName(String name) {
    RouteUtil.pushName(name, context);
  }

  void pop() {
    RouteUtil.pop(context);
  }

  void maybePop() {
    RouteUtil.maybePop(context);
  }

  void popWithData(data) {
    RouteUtil.popWithData(data, context);
  }

  void popToRoot() {
    RouteUtil.popToRoot(context);
  }

  void push(Widget widget) {
    RouteUtil.push(widget, context);
  }

  void scalePush(Widget widget) {
    RouteUtil.scalePush(widget, context);
  }

  Future pushAndReturn(Widget widget) {
    return RouteUtil.pushAndReturn(widget, context);
  }

  void pushAndRemoveUntil(Widget widget) {
    RouteUtil.pushAndRemoveUntil(widget, context);
  }

  void pushReplacement(Widget widget) {
    RouteUtil.pushReplacement(widget, context);
  }

  void pushAndReceive(Widget widget, Function receive) {
    RouteUtil.pushAndReceive(widget, receive, context);
  }

  sState(Function func) {
    if (!mounted) return;
    setState(func);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) {
      onResume();
    });
  }

  void onResume() {}
}