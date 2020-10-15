/*
 * @Project:        snp
 * @Package:        ui.pages.mine
 * @FileName:       nickname_page
 * @Create:         2020/8/27 12:46 PM
 * @Description:    
 * @author          dt
*/

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/pages/main_page.dart';
import 'package:snp/ui/store/user.dart';

class NicknamePage extends StatefulWidget {
  final bool asModel;

  NicknamePage({
    Key key,
    this.asModel = false,
  }) : super(key: key);

  @override
  _NicknamePageState createState() => _NicknamePageState();
}

class _NicknamePageState extends BaseState<NicknamePage> {
  TextEditingController _controller;
  bool _didEdit = false;
  bool _didInput = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.asModel
          ? PreferredSize(
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
                        isDisable: !_didEdit &&
                            !ObjectUtil.isEmptyString(_controller.text),
                        disableBackColor: CColor.disableColor,
                        onClick: () => _setNickname(context),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : AppBar(),
      body: Container(
        margin: widget.asModel ? sInsetsAll(30) : sInsetsLTRB(30, 0, 30, 30),
        height: screenHeight - statusBarHeight - appBarHeight - sHeight(150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "请填写你的昵称",
              style: Font.title,
            ),
            gap(height: 20),
            Text(
              "昵称最长20个字符，支持中英文，允许空格及下划线",
              style: Font.hintS,
            ),
            gap(height: 20),
            TextField(
              controller: _controller,
//                    keyboardType: TextInputType.phone,
              autofocus: true,
              cursorColor: CColor.mainColor,
              style: Font.normal,
              decoration: InputDecoration(
//                filled: true,
//                fillColor: CColor.bgPartColor,
                contentPadding: sInsetsHV(5, 10),
//                border: InputBorder.none,
                hintText: '昵称',
                hintStyle: Font.hint,
//                enabledBorder: OutlineInputBorder(
//                  borderSide: BorderSide(color: CColor.bgPartColor),
//                  borderRadius: BorderRadius.circular(10),
//                ),
//                focusedBorder: OutlineInputBorder(
//                  borderSide: BorderSide(color: CColor.bgPartColor),
//                  borderRadius: BorderRadius.circular(10),
//                ),
                suffixIcon: _didInput
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          size: 20,
                        ),
                        onPressed: () => _controller.text = '',
                      )
                    : null,
              ),
              onChanged: (text) {
                sState(() {
                  _didEdit = text != globalUserStore.bean.nickname;
                  _didInput = !ObjectUtil.isEmptyString(text);
                });
              },
            ),
            Expanded(child: gap()),
            Visibility(
              visible: !widget.asModel,
              child: Center(
                child: CommonButton(
                  text: "下一步",
                  onClick: () => _setNickname(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setNickname(BuildContext context) async {
    if (ObjectUtil.isEmptyString(_controller.text)) {
      toast('请输入昵称');
      return;
    }
    afterLoading(globalUserStore.setNickname(_controller.text)).then((value) {
      if (value) {
        toast('昵称设置成功');
        if (widget.asModel)
          pop();
        else
          RouteUtil.pushAndRemoveUntil(MainPage(), context);
      } else
        toast('昵称设置失败');
    });
  }

  @override
  void initState() {
    _controller = TextEditingController(
        text: widget.asModel ? globalUserStore.bean.nickname : '');
    _didInput = widget.asModel
        ? !ObjectUtil.isEmptyString(globalUserStore.bean.nickname)
        : false;
    super.initState();
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }
}
