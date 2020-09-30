/*
 * 项目名:    snp
 * 包名       base
 * 文件名:    base_container
 * 创建时间:  2020/8/25 on 10:09 AM
 * 描述:     
 *
 * @author   Dino
 */

import 'package:flutter/material.dart';
import 'package:snp/common/base/base_color.dart';
import 'package:snp/common/utils/ui_util.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  final bool isShow;
  final double gradientHeight;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const BaseContainer({
    Key key,
    this.child,
    this.isShow = false,
    this.gradientHeight = 0.0,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];
    if (gradientHeight >= 0)
      widgets.add(gradientContainer(context));
    else
      widgets.add(gradientContainerFullScreen());
    widgets.add(child);
//    widgets.add(ProgressDialog(
//      loading: this.isShow,
//      msg: '加载中',
//    ));
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        margin: margin,
        padding: padding,
        child: Stack(
          children: widgets,
        ),
      ),
    );
  }

  Widget gradientContainer(BuildContext context) {
    return Positioned(
      right: 0.0,
      left: 0.0,
      top: 0.0,
      child: Container(
        color: CColor.mainColor,
        child: Row(
          children: <Widget>[
            Container(
              width: kToolbarHeight,
              height: gradientHeight > 0 ? 10 : 0,
            ),
            Container(
              decoration: BoxDecoration(
//                color: CColor.mainColor,
                gradient: LinearGradient(
                  colors: [
                    CColor.mainColor,
                    Color(0xFFFE9202),
                  ],
                ),
              ),
              height: sHeight(gradientHeight),
              width: MediaQuery.of(context).size.width - kToolbarHeight,
            ),
          ],
        ),
      ),
    );
  }

  Widget gradientContainerFullScreen() {
    return Positioned(
      right: 0.0,
      left: 0.0,
      top: 0.0,
      bottom: 0.0,
      child: Container(
        color: CColor.mainColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: kToolbarHeight),
                decoration: BoxDecoration(
//                  color: CColor.mainColor,
                  gradient: LinearGradient(
                    colors: [
                      CColor.mainColor,
                      Color(0xFFFE9202),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
