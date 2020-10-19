/*
 * 项目名:    snp
 * 包名       base.utils
 * 文件名:    ui_util
 * 创建时间:  2020/8/25 on 11:22 AM
 * 描述:     
 *
 * @author   Dino
 */
import 'package:bot_toast/bot_toast.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:snp/common/base/base_color.dart';
import 'package:snp/ui/widgets/loading_dialog.dart';

/// screen width
/// 屏幕 宽
double get screenWidth => ScreenUtil.getInstance().screenWidth;

/// screen height
/// 屏幕 高
double get screenHeight => ScreenUtil.getInstance().screenHeight;

/// 类似于iPhone XR 底部安全区域
double get bottomBarHeight => ScreenUtil.getInstance().bottomBarHeight;

/// 状态栏高度
double get statusBarHeight => ScreenUtil.getInstance().statusBarHeight;

///标题栏(AppBar)高度
double get appBarHeight => ScreenUtil.getInstance().appBarHeight;

double sFontSize(double size, {sc = true}) {
  if (!sc) return size;
  setDesignWHD(375, 667,
      density: ScreenUtil.getInstance().mediaQueryData.devicePixelRatio);
  return ScreenUtil.getInstance().getSp(size);
}

double sHeight(double size) {
  setDesignWHD(375, 667,
      density: ScreenUtil.getInstance().mediaQueryData.devicePixelRatio);
  return ScreenUtil.getInstance().getHeight(size);
}

double sWidth(double size) {
  setDesignWHD(375, 667,
      density: ScreenUtil.getInstance().mediaQueryData.devicePixelRatio);
  return ScreenUtil.getInstance().getWidth(size);
}

EdgeInsets sInsetsLTRB(
  double left,
  double top,
  double right,
  double bottom, {
  sc = true,
}) {
  return EdgeInsets.fromLTRB(
    sc ? sWidth(left) : left,
    sc ? sHeight(top) : top,
    sc ? sWidth(right) : right,
    sc ? sHeight(bottom) : bottom,
  );
}

EdgeInsets sInsetsAll(
  double value, {
  sc = true,
}) {
  return EdgeInsets.fromLTRB(
    sc ? sWidth(value) : value,
    sc ? sHeight(value) : value,
    sc ? sWidth(value) : value,
    sc ? sHeight(value) : value,
  );
}

EdgeInsets sInsetsHV(
  double h,
  double v, {
  sc = true,
}) {
  return EdgeInsets.fromLTRB(
    sc ? sWidth(h) : h,
    sc ? sHeight(v) : v,
    sc ? sWidth(h) : h,
    sc ? sHeight(v) : v,
  );
}

gap({
  double width = 0.0,
  double height = 0.0,
  sc = true,
}) {
  return SizedBox(
    width: sc ? sWidth(width) : width,
    height: sc ? sHeight(height) : height,
  );
}

line({double width = 1.0, double height = 1.0, EdgeInsets margin}) {
  return Container(
    width: width,
    height: height,
    margin: margin,
    color: CColor.lineColor,
  );
}

ts({double s = 14, Color c = CColor.textColor, sc = true}) {
  return TextStyle(fontSize: sFontSize(s, sc: sc), color: c);
}

/// 显示加载提示
showLoading() => Loading().show();

/// 关闭加载提示
dismissLoading() => Loading().dismiss();

/// 传入异步操作,自动显示和隐藏加载提示
afterLoading<T>(Future<T> action, {int seconds = 2}) async =>
    await Loading().afterShow(
      action,
      minDurationSeconds: seconds,
    );

/// 显示一个Toast
toast(String msg, {int duration = 2}) {
  BotToast.showText(
    text: msg ?? '',
    duration: Duration(seconds: duration),
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Font {
  //一般字体
  static TextStyle normal = ts(c: CColor.textColor);
  static TextStyle minor = ts(c: CColor.minorTextColor);
  static TextStyle hint = ts(c: CColor.hintTextColor);
  static TextStyle light = ts(c: CColor.lightTextColor);
  static TextStyle red = ts(c: CColor.red);
  static TextStyle overMain = ts(c: CColor.overMainTextColor);

  //小字体
  static TextStyle normalS = ts(s: 12, c: CColor.textColor);
  static TextStyle minorS = ts(s: 12, c: CColor.minorTextColor);
  static TextStyle hintS = ts(s: 12, c: CColor.hintTextColor);
  static TextStyle lightS = ts(s: 12, c: CColor.lightTextColor);
  static TextStyle redS = ts(s: 12, c: CColor.red);
  static TextStyle overMainS = ts(s: 12, c: CColor.overMainTextColor);

  //超小字体
  static TextStyle normalXS = ts(s: 10, c: CColor.textColor);
  static TextStyle minorXS = ts(s: 10, c: CColor.minorTextColor);
  static TextStyle hintXS = ts(s: 10, c: CColor.hintTextColor);
  static TextStyle lightXS = ts(s: 10, c: CColor.lightTextColor);
  static TextStyle redXS = ts(s: 10, c: CColor.red);
  static TextStyle overMainXS = ts(s: 10, c: CColor.overMainTextColor);

  //大字体
  static TextStyle normalL = ts(s: 16, c: CColor.textColor);
  static TextStyle minorL = ts(s: 16, c: CColor.minorTextColor);
  static TextStyle hintL = ts(s: 16, c: CColor.hintTextColor);
  static TextStyle lightL = ts(s: 16, c: CColor.lightTextColor);
  static TextStyle redL = ts(s: 16, c: CColor.red);
  static TextStyle overMainL = ts(s: 16, c: CColor.overMainTextColor);

  //超大字体
  static TextStyle normalH = ts(s: 18, c: CColor.textColor);
  static TextStyle minorH = ts(s: 18, c: CColor.minorTextColor);
  static TextStyle hintH = ts(s: 18, c: CColor.hintTextColor);
  static TextStyle lightH = ts(s: 18, c: CColor.lightTextColor);
  static TextStyle redH = ts(s: 18, c: CColor.red);
  static TextStyle overMainH = ts(s: 18, c: CColor.overMainTextColor);

//  //超大加粗字体
//  static TextStyle normalHB = ts(s: 18, c: CColor.textColor);
//  static TextStyle minorHB = ts(s: 18, c: CColor.minorTextColor);
//  static TextStyle hintHB = ts(s: 18, c: CColor.hintTextColor);
//  static TextStyle lightHB = ts(s: 18, c: CColor.lightTextColor);

  static TextStyle button = ts(s: 16, c: Colors.white);
  static TextStyle title = TextStyle(
    fontSize: sFontSize(18),
    color: CColor.textColor,
    fontWeight: FontWeight.w500,
  );
}

class NFont {
  //一般字体
  static TextStyle normal = ts(c: CColor.textColor, sc: false);
  static TextStyle minor = ts(c: CColor.minorTextColor, sc: false);
  static TextStyle hint = ts(c: CColor.hintTextColor, sc: false);
  static TextStyle light = ts(c: CColor.lightTextColor, sc: false);
  static TextStyle overMain = ts(c: CColor.overMainTextColor, sc: false);

  //小字体
  static TextStyle normalS = ts(s: 12, c: CColor.textColor, sc: false);
  static TextStyle minorS = ts(s: 12, c: CColor.minorTextColor, sc: false);
  static TextStyle hintS = ts(s: 12, c: CColor.hintTextColor, sc: false);
  static TextStyle lightS = ts(s: 12, c: CColor.lightTextColor, sc: false);
  static TextStyle overMainS =
      ts(s: 12, c: CColor.overMainTextColor, sc: false);

  //超小字体
  static TextStyle normalXS = ts(s: 10, c: CColor.textColor, sc: false);
  static TextStyle minorXS = ts(s: 10, c: CColor.minorTextColor, sc: false);
  static TextStyle hintXS = ts(s: 10, c: CColor.hintTextColor, sc: false);
  static TextStyle lightXS = ts(s: 10, c: CColor.lightTextColor, sc: false);
  static TextStyle overMainXS =
      ts(s: 10, c: CColor.overMainTextColor, sc: false);

  //大字体
  static TextStyle normalL = ts(s: 16, c: CColor.textColor, sc: false);
  static TextStyle minorL = ts(s: 16, c: CColor.minorTextColor, sc: false);
  static TextStyle hintL = ts(s: 16, c: CColor.hintTextColor, sc: false);
  static TextStyle lightL = ts(s: 16, c: CColor.lightTextColor, sc: false);
  static TextStyle overMainL =
      ts(s: 16, c: CColor.overMainTextColor, sc: false);

  //超大字体
  static TextStyle normalH = ts(s: 18, c: CColor.textColor, sc: false);
  static TextStyle minorH = ts(s: 18, c: CColor.minorTextColor, sc: false);
  static TextStyle hintH = ts(s: 18, c: CColor.hintTextColor, sc: false);
  static TextStyle lightH = ts(s: 18, c: CColor.lightTextColor, sc: false);
  static TextStyle overMainH =
      ts(s: 18, c: CColor.overMainTextColor, sc: false);

//  //超大加粗字体
//  static TextStyle normalHB = ts(s: 18, c: CColor.textColor);
//  static TextStyle minorHB = ts(s: 18, c: CColor.minorTextColor);
//  static TextStyle hintHB = ts(s: 18, c: CColor.hintTextColor);
//  static TextStyle lightHB = ts(s: 18, c: CColor.lightTextColor);

  static TextStyle button = ts(s: 16, c: Colors.white, sc: false);
  static TextStyle title = TextStyle(
    fontSize: sFontSize(18, sc: false),
    color: CColor.textColor,
    fontWeight: FontWeight.w500,
  );
}
