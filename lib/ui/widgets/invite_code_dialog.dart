/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       invite_code_dialog
 * @Create:         2020/10/11 5:33 AM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snp/common/common.dart';

class InviteCodeView extends StatelessWidget {
  final String code;
  final Function closed;

  const InviteCodeView({
    Key key,
    @required this.code,
    this.closed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenWidth - sWidth(100),
          // height: sHeight(300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              gap(height: 40),
              Text(
                '请将一下邀请码发送给被邀请者',
                style: Font.minorS,
              ),
              gap(height: 40),
              // Text(
              //   '邀请码',
              //   style: Font.normalS,
              // ),
              // gap(height: 10),
              Text(
                code,
                style: ts(
                  s: 22,
                  c: CColor.textColor,
                ),
              ),
              gap(height: 80),
              CommonButton(
                text: '复制',
                fontSize: sFontSize(14),
                width: sWidth(130),
                height: sHeight(28),
                onClick: () => Clipboard.setData(
                  ClipboardData(
                    text: code,
                  ),
                ).then(
                  (value) => toast('复制成功'),
                ),
              ),
              gap(height: 30),
            ],
          ),
        ),
        gap(height: 50),
        ClipOval(
          child: SizedBox(
            height: 60,
            width: 60,
            child: FlatButton(
              padding: sInsetsAll(0),
              shape: CircleBorder(
                side: BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              onPressed: () {
                pop();
                if (closed != null) closed();
              },
              child: Center(
                child: Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
