/*
 * @Project:        snp
 * @Package:        ui
 * @FileName:       splash_page
 * @Create:         2020/8/26 2:53 PM
 * @Description:
 * @author          dt
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:snp/common/common.dart';
import 'package:snp/ui/pages/login/login_page.dart';
import 'package:snp/ui/pages/main_page.dart';
import 'package:snp/ui/store/main_store.dart';

class SplashPage extends StatelessWidget {
  final int duration;

  SplashPage(this.duration);

  final _start = mobx.Observable(false);

  bool get start => _start.value;

  set start(bool newValue) => _start.value = newValue;

  @override
  Widget build(BuildContext context) {
    mobx.Action setStart = mobx.Action(() {
      start = !start;
    });
    Timer(
      Duration(milliseconds: 300),
      setStart,
    );
    Timer(
      Duration(seconds: duration),
      () {
        if (globalMainStore().allianceId != -1)
          RouteUtil.pushReplacement(MainPage(), context);
        else
          RouteUtil.pushReplacement(LoginPage(), context);
      },
    );
    return Scaffold(
      body: Container(
        color: CColor.mainColor,
        child: Stack(
          children: [
            Positioned(
              top: screenHeight / 2 + 80,
              left: screenWidth / 2 - sWidth(30),
              width: sWidth(60),
              child: Center(
                child: Text(
                  "SNP",
                  style: ts(s: 28, c: CColor.bgColor),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () => setStart(),
                child: Observer(
                  builder: (_) => AnimatedContainer(
                    width: start ? 120 : screenWidth,
                    height: start ? 120 : screenHeight + statusBarHeight,
                    padding: EdgeInsets.all(20),
                    child: AnimatedOpacity(
                      opacity: start ? 1 : 0,
                      duration: Duration(milliseconds: 500),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    decoration: BoxDecoration(
                      color: CColor.cardColor,
                      borderRadius: BorderRadius.circular(start ? 60 : 0),
                    ),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
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
