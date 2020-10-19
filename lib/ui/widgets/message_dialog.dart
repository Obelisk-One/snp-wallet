/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       message_dialog
 * @Create:         2020/8/27 10:46 AM
 * @Description:    
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';

// ignore: must_be_immutable
class MessageDialog extends StatelessWidget {
  final String title;
  final message;
  final String leftText;
  final String rightText;
  TextStyle titleStyle;
  TextStyle messageStyle;
  TextStyle leftStyle;
  TextStyle rightStyle;
  final bool showClose, showLeft, showRight;
  final Function onLeftClick;
  final Function onRightClick;

  MessageDialog({
    this.title = '',
    @required this.message,
    this.leftText = '取消',
    this.rightText = '确定',
    this.titleStyle,
    this.messageStyle,
    this.leftStyle,
    this.rightStyle,
    this.showClose = false,
    this.showLeft = true,
    this.showRight = true,
    this.onLeftClick,
    this.onRightClick,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (titleStyle == null) titleStyle = Font.title;
    if (messageStyle == null) messageStyle = Font.normal;
    if (leftStyle == null) leftStyle = Font.minorL;
    if (rightStyle == null) rightStyle = Font.lightL;

    return Padding(
      padding: sInsetsAll(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CColor.lightCardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                gap(height: 20),
                Visibility(
                  visible: title.isNotEmpty,
                  child: Padding(
                    padding: sInsetsLTRB(20, 0, 20, 10),
                    child: Text(title, style: titleStyle),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenHeight * .5,
                    maxWidth: screenWidth - sWidth(40),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: sInsetsHV(20, 0),
                      child: message is String
                          ? Text(message, style: messageStyle)
                          : message,
                    ),
                  ),
                ),
                gap(height: 20),
                Visibility(
                  visible: showLeft || showRight,
                  child: Divider(),
                ),
                Visibility(
                  visible: showLeft || showRight,
                  child: Container(
                    height: 45,
                    child: Row(
                      children: [
                        Visibility(
                          visible: showLeft,
                          child: Flexible(
                            flex: 1,
                            child: CommonButton(
                              text: leftText,
                              width: double.infinity,
                              height: 45,
                              radius: 0,
                              elevation: 0,
                              backColor: Colors.transparent,
                              textColor: leftStyle.color,
                              fontSize: leftStyle.fontSize,
                              onClick: onLeftClick ?? pop,
                            ),
                          ),
                        ),
                        VerticalDivider(),
                        Visibility(
                          visible: showRight,
                          child: Flexible(
                            flex: 1,
                            child: CommonButton(
                              text: rightText,
                              width: double.infinity,
                              height: 45,
                              radius: 0,
                              elevation: 0,
                              backColor: Colors.transparent,
                              textColor: rightStyle.color,
                              fontSize: rightStyle.fontSize,
                              onClick: onRightClick ?? pop,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double get _buttonWidth => (screenWidth - sWidth(40) - 1) / 2;
}
