/*
 * @Project:        snp
 * @Package:        ui.pages.login
 * @FileName:       login_page
 * @Create:         2020/8/26 7:25 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/pages/login/names_setting_page.dart';
import 'package:snp/ui/pages/login/register_page.dart';
import 'package:snp/ui/pages/login/verify_key_page.dart';
import 'package:snp/ui/pages/mine/nickname_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: sInsetsLTRB(0, 120, 0, 0),
              // padding: EdgeInsets.all(20),
              width: sWidth(80),
              height: sWidth(80),
              child: Image.asset('assets/images/logo.png'),
            ),
            // Container(
            //   width: sWidth(80),
            //   height: sWidth(80),
            //   margin: sInsetsLTRB(0, 120, 0, 0),
            //   decoration: BoxDecoration(
            //     color: CColor.mainColor,
            //     borderRadius: BorderRadius.circular(7),
            //   ),
            //   child: Center(
            //     child: Icon(
            //       SnpIcon.logo,
            //       color: CColor.bgColor,
            //       size: sFontSize(40),
            //     ),
            //   ),
            // ),
            gap(height: 20),
            Text("SNP", style: ts(s: 28)),
            Expanded(
              child: Container(
                width: screenWidth,
              ),
            ),
            CommonButton(
              margin: sInsetsLTRB(30, 0, 30, 10),
              text: "已有账户",
              onClick: () => push(VerifyKeyPage()),
            ),
            CommonButton(
              margin: sInsetsLTRB(30, 30, 30, 90),
              text: "首次进入网络",
              textColor: CColor.mainColor,
              backColor: CColor.minorColor,
              borderColor: CColor.mainColor,
              borderWidth: 1,
              onClick: () => push(NamesSettingPage()),
            ),
          ],
        ),
      ),
    );
  }
}
