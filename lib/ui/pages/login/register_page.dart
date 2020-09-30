/*
 * @Project:        snp
 * @Package:        ui.pages.login
 * @FileName:       register_page
 * @Create:         2020/8/27 10:35 AM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/pages/alliance_select_page.dart';
import 'package:snp/ui/pages/main_page.dart';
import 'package:snp/ui/store/main_store.dart';

class RegisterPage extends StatelessWidget {
  final String passwords;

  const RegisterPage(this.passwords, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: sInsetsHV(30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "请记住以下密码，将作为你的唯一登录密码",
                    style: Font.title,
                  ),
                  gap(height: 20),
                  Text(
                    "最好是手写记下，保存在安全的地方。\n请勿使用记事本、邮箱、笔记应用记录密码！",
                    style: Font.hintS,
                  ),
                  gap(height: 20),
                  Text(passwords.isEmpty ? '密钥生成失败,请稍后重试' : passwords),
                ],
              ),
            ),
          ),
          Divider(
            color: CColor.minorColor,
          ),
          Container(
            height: sHeight(50),
            padding: sInsetsAll(10),
            margin: EdgeInsets.only(bottom: bottomBarHeight),
            child: Align(
              alignment: Alignment.centerRight,
              child: CommonButton(
                width: 75,
                height: 30,
                text: "下一步",
                fontSize: sFontSize(14),
                textColor: CColor.overMainTextColor,
                onClick: () => showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text("确认操作"),
                    content: Text("已经保存好密码，直接进入网络？"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("返回"),
                        textColor: CColor.hintTextColor,
                        onPressed: () => RouteUtil.pop(context),
                      ),
                      FlatButton(
                        child: Text("进入网络"),
                        textColor: CColor.lightTextColor,
                        onPressed: () {
                          pop();
                          // if (globalMainStore(context).selectedAllianceId == -1)
                            RouteUtil.pushAndRemoveUntil(AllianceSelectPage(), context);
                          // else
                          //   RouteUtil.pushAndRemoveUntil(MainPage(), context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
