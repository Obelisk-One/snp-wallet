/*
 * @Project:        snp
 * @Package:        ui.pages.board
 * @FileName:       invite_user_view
 * @Create:         2020/9/18 2:57 PM
 * @Description:    
 * @author          dt
*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/oss_util.dart';
import 'package:snp/main.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/image_selector_view.dart';
import 'package:snp/ui/widgets/invite_code_dialog.dart';

class InviteUserView extends StatelessWidget {
  final _controller = TextEditingController();
  final _store = ImageSelectorStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(statusBarHeight + appBarHeight),
        child: Padding(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: AppBar(
            brightness: Brightness.dark,
            elevation: 0,
            leading: IconButton(
              onPressed: () => pop(),
              icon: Icon(
                Icons.close,
                size: 25,
                color: CColor.iconColor,
              ),
            ),
            title: Text('引入新成员'),
            actions: [
              UnconstrainedBox(
                child: CommonButton(
                  text: '提交',
                  radius: sHeight(12.5),
                  width: sWidth(60),
                  height: sHeight(25),
                  margin: sInsetsLTRB(0, 0, 15, 0),
                  fontSize: sFontSize(14),
                  disableBackColor: CColor.disableColor,
                  onClick: _commit,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              cursorColor: CColor.mainColor,
              style: Font.normal,
              maxLength: 200,
              maxLines: 8,
              decoration: InputDecoration(
                filled: true,
                fillColor: CColor.bgGrayColor,
                contentPadding: sInsetsAll(10),
                border: InputBorder.none,
                hintText: '填写成员适合加入联盟的原因...',
                hintStyle: Font.hint,
              ),
            ),
            gap(height: 30),
            ImageSelectorView(
              store: _store,
              maxImage: 3,
            ),
          ],
        ),
      ),
    );
  }

  _commit() {
    if (_controller.text.isEmpty) {
      toast('请填写成员适合加入联盟的原因');
      return;
    }
    _store.uploadDone = () {
      if (!_store.noError) {
        dismissLoading();
        toast('有图片上传失败,请重新提交');
        print('upload not finished');
        return;
      }
      if (!_store.isAllUploaded) {
        dismissLoading();
        toast('还有图片未上传,请重新提交');
        print('upload not finished');
        return;
      }
      print('upload done');
      http.post(
        API.getInviteCode,
        params: {
          'league_id': globalMainStore().allianceId,
          'message': _controller.text,
          'images': _store.keys,
        },
        onSuccess: (data) {
          dismissLoading();
          showDialog(
            context: rootKey.currentContext,
            builder: (BuildContext context) => InviteCodeView(
              code: data.data,
              closed: () => pop(),
            ),
            barrierDismissible: true,
          );
        },
        onError: (error) {
          dismissLoading();
          toast(error.msg);
          // _store.keys.forEach(
          //   (e) => oss.deleteImage(
          //     e,
          //     onFinish: (success, key) {},
          //   ),
          // );
        },
      );
    };
    showLoading();
    _store.uploadImages();
  }
}
