/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       loading_dialog
 * @Create:         2020/9/3 7:21 PM
 * @Description:    
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snp/common/base/base_color.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/ui_util.dart';
import 'package:snp/main.dart';

class LoadingDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        type: MaterialType.transparency, //透明类型
        child: Center(
          child: Container(
            width: sWidth(100),
            height: sWidth(100),
            padding: sInsetsAll(15),
            decoration: BoxDecoration(
              color: CColor.cardColor,
              borderRadius: BorderRadius.circular(10),
//        boxShadow: [
//          BoxShadow(
//            color: CColor.shadowColor,
//            offset: Offset(0.0, 2.0),
//            blurRadius: 9.0,
//          ),
//        ],
            ),
            child: SpinKitDoubleBounce(
              color: CColor.mainColor,
              size: sWidth(50),
            ),
          ),
        ),
      ),
    );
  }
}

class Loading {
  // 单例公开访问点
  factory Loading() => _sharedInstance();

  // 静态私有成员
  // static Loading _instance;//懒汉模式(加载时速度较快，运行时获取实例速度较慢)
  static Loading _instance = Loading._(); //饿汉模式(加载时获取实例速度较慢，运行时速度较快)

  // 私有构造函数
  Loading._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static Loading _sharedInstance() {
    return _instance;
  }

  LoadingDialog _dialog;
  bool isShowing = false;

  show() {
    if (_dialog == null) _dialog = LoadingDialog();
    if (isShowing) return;
    isShowing = true;
    showDialog(
      context: rootKey.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingDialog(),
    );
  }

  dismiss() {
    if (!isShowing) return;

    isShowing = false;
    RouteUtil.pop(rootKey.currentContext);
  }

  Future<dynamic> afterShow<T>(
    Future<T> action, {
    int minDurationSeconds = 2,
  }) async {
    var result;
    DateTime begin = DateTime.now();
    var onFinish = () async => Future.delayed(
          Duration(
            seconds:
                DateTime.now().difference(begin).inSeconds < minDurationSeconds
                    ? minDurationSeconds
                    : 0,
          ),
          () => dismiss(),
        );
    try {
      show();
      if (action != null){
        result = await action;
        await onFinish();
      }
      else
        await onFinish();

      return result;
    } catch (e) {
      await onFinish();
      return false;
    }
  }
}
