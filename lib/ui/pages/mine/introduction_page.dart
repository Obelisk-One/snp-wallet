/*
 * @Project:        snp
 * @Package:        ui.pages.mine
 * @FileName:       introduction_page
 * @Create:         2020/9/4 6:20 PM
 * @Description:    
 * @author          dt
*/
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snp/common/common.dart';
import 'package:snp/main.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/store/user.dart';

class IntroductionPage extends StatefulWidget {
  IntroductionPage({Key key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends BaseState<IntroductionPage> {
  TextEditingController _controller;
  bool _canSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(statusBarHeight + appBarHeight),
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: AppBar(
            elevation: 1,
            leading: CupertinoButton(
              onPressed: () => pop(),
              child: Text(
                '取消',
                style: Font.normal,
              ),
            ),
            leadingWidth: sWidth(70),
            actions: [
              UnconstrainedBox(
                child: CommonButton(
                  text: '确定',
                  radius: 5,
                  width: sWidth(55),
                  height: sHeight(25),
                  margin: sInsetsLTRB(0, 0, 15, 0),
                  fontSize: sFontSize(14),
                  isDisable: !_canSubmit,
                  disableBackColor: CColor.disableColor,
                  onClick: _setDescription,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: sInsetsAll(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "请填写你的简介",
              style: Font.title,
            ),
            gap(height: 20),
            Text(
              "简介最长200个字符，支持中英文及Emoji表情",
              style: Font.hintS,
            ),
            gap(height: 20),
            TextField(
              controller: _controller,
              autofocus: true,
              cursorColor: CColor.mainColor,
              style: Font.light,
              maxLength: 200,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: CColor.bgPartColor,
                contentPadding: sInsetsAll(10),
                border: InputBorder.none,
                hintText: '简介',
                hintStyle: Font.hint,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CColor.bgPartColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CColor.bgPartColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (text) => sState(
                    () => _canSubmit = globalUserStore.bean.disc != text &&
                    !ObjectUtil.isEmptyString(text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setDescription() {
    if (!_canSubmit) return;
    // bool result=_store.setDescription(_controller.text);
    afterLoading(globalUserStore.setDescription(_controller.text)).then((value) {
      if (value) {
        toast('设置成功');
        pop();
      } else
        toast('设置失败');
    });
  }

  @override
  void initState() {
    _controller = TextEditingController(text: globalUserStore.bean.disc);
    super.initState();
  }
  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }
}
