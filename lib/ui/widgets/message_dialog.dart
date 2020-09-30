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

class MessageDialog extends Dialog {
  final String title;
  final String message;
  final String negativeText;
  final String positiveText;
  final bool showClose;
  final Function onCloseEvent;
  final Function onPositivePressEvent;

  MessageDialog({
    Key key,
    @required this.title,
    @required this.message,
    this.negativeText,
    this.positiveText,
    this.onPositivePressEvent,
    this.showClose = true,
    @required this.onCloseEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sInsetsAll(15),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
              ),
              margin: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        Center(
                          child: Text(
                            title,
                            style: Font.normalL,
                          ),
                        ),
                        _renderCloseButton(context),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minHeight: 90.0),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: IntrinsicHeight(
                        child: Text(
                          message,
                          style: Font.normal,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xffe0e0e0),
                    height: 1.0,
                  ),
                  this._buildBottomButtonGroup(context,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderCloseButton(BuildContext context){
    if(showClose){
      return GestureDetector(
        onTap: () {
          Navigator.of(context).maybePop();
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.close,
            color: Color(0xffe0e0e0),
          ),
        ),
      );
    }
    else{
      return Container();
    }
  }

  Widget _buildBottomButtonGroup(BuildContext context,) {
    var widgets = <Widget>[];
    if (negativeText != null && negativeText.isNotEmpty)
      widgets.add(_buildBottomCancelButton(context,));
    if (positiveText != null && positiveText.isNotEmpty)
      widgets.add(_buildBottomPositiveButton(context,));
    return Flex(
      direction: Axis.horizontal,
      children: widgets,
    );
  }

  Widget _buildBottomCancelButton(BuildContext context,) {
    return Flexible(
      fit: FlexFit.tight,
      child: FlatButton(
        onPressed: onCloseEvent,
        child: Text(
          negativeText,
          style: Font.hintL,
        ),
      ),
    );
  }

  Widget _buildBottomPositiveButton(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: FlatButton(
        onPressed: onPositivePressEvent,
        child: Text(
          positiveText,
          style: Font.normalL,
        ),
      ),
    );
  }

//  double sFontSize(BuildContext context, double size) {
//    setDesignWHD(375,667,density: MediaQuery.of(context).devicePixelRatio);
//    return ScreenUtil.getScaleSp(context, size);
//  }
}