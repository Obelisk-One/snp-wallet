/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       common_button
 * @Create:         2020/8/26 7:31 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/common/base/base_color.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/ui_util.dart';

class CommonButton extends StatelessWidget {
  final Function onClick;

  final String text;
  final Widget child;

  final double height;
  final double width;

  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double fontSize;

  final bool isDisable;

  final Color backColor;
  final Color textColor;

  final Color disableBackColor;
  final Color disableTextColor;

  final Color borderColor;
  final double borderWidth;

  final double elevation;
  final double radius;

  CommonButton({
    Key key,
    this.text = '',
    this.child,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.fontSize,
    this.isDisable = false,
    this.backColor,
    this.textColor,
    this.disableBackColor,
    this.disableTextColor,
    this.borderWidth = 0,
    this.borderColor = Colors.transparent,
    this.elevation = 2,
    this.radius,
    @required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    Widget button;
    button = RaisedButton(
      elevation: elevation,
      highlightElevation: elevation,
      child: child ??
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? sFontSize(18),
              color: textColor ?? Colors.white,
            ),
          ),
      padding: sInsetsAll(0),
      color: backColor ?? CColor.mainColor,
      disabledColor: disableBackColor ?? CColor.mainDisableColor,
      disabledTextColor: disableTextColor ?? Colors.white,
      onPressed: isDisable ? null : onClick,
      shape: isEmpty(radius)
          ? StadiumBorder(
              side: BorderSide(
                width: borderWidth,
                color: borderColor,
              ),
            )
          : RoundedRectangleBorder(
              side: BorderSide(
                width: borderWidth,
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(radius),
            ),
    );
    return Container(
      margin: margin ?? sInsetsAll(0),
      padding: padding ?? sInsetsAll(0),
      child: SizedBox(
        height: height ?? sHeight(40),
        width: width ?? sWidth(300),
        child: button,
      ),
    );
  }
}
