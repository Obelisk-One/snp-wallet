/*
 * @Project:        snp
 * @Package:        ui.pages.login
 * @FileName:       verify_key_page
 * @Create:         2020/8/26 8:13 PM
 * @Description:    
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/user_util.dart';
import 'package:snp/main.dart';
import 'package:snp/ui/pages/alliance_select_page.dart';
import 'package:snp/ui/pages/main_page.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/store/user.dart';

class VerifyKeyPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController(
    // text:
    //     'panther,frown,blame,addict,hotel,vendor,joy,advice,fork,proud,first,report,nuclear,pigeon,youth,suspect,hero,describe,exercise,tongue,seminar,impact,wrong,right',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
//              color: Colors.red,
              margin: sInsetsHV(30, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "请填写你的专属密码",
                    style: Font.title,
                  ),
                  gap(height: 20),
                  Text(
                    "注意大小写",
                    style: Font.hintS,
                  ),
                  gap(height: 20),
                  TextField(
                    controller: _controller,
//                    keyboardType: TextInputType.phone,
                    cursorColor: CColor.mainColor,
                    style: Font.light,
                    decoration: InputDecoration(
                      contentPadding: sInsetsAll(0),
//                      border: InputBorder.none,
                      hintText: '请填写你的专属密码',
                      hintStyle: Font.hint,
                    ),
                    onEditingComplete: () => _doVerify(context),
                  ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonButton(
                  width: 75,
                  height: 30,
                  text: "验证",
                  fontSize: sFontSize(14),
                  textColor: CColor.overMainTextColor,
                  onClick: () => _doVerify(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _doVerify(BuildContext context) {
    showLoading();
    globalUserStore.verifyWithWords(
      words: _controller.text,
      onSuccess: (data) {
        dismissLoading();
        toast('验证通过');
        // if (globalMainStore(context).selectedAllianceId == -1)
          RouteUtil.pushAndRemoveUntil(AllianceSelectPage(), context);
        // else
        //   RouteUtil.pushAndRemoveUntil(MainPage(), context);
      },
      onError: (error) {
        dismissLoading();
        toast('验证不通过\n${error.msg}');
      },
    );
  }
}
