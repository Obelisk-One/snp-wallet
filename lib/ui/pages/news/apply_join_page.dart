/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       apply_join_page
 * @Create:         2020/10/11 10:50 AM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/image_selector_view.dart';

class ApplyJoinPage extends StatefulWidget {
  @override
  _ApplyJoinPageState createState() => _ApplyJoinPageState();
}

class _ApplyJoinPageState extends BaseState<ApplyJoinPage> {
  TextEditingController _codeController;
  TextEditingController _reasonController;
  ImageSelectorStore _store;
  bool _showBody = false;
  bool _needCode = true;

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
            // title: Text('申请加入联盟'),
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
      body: _showBody
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Visibility(
                    visible: _needCode,
                    child: Container(
                      margin: sInsetsLTRB(10, 0, 10, 20),
                      child: TextField(
                        controller: _codeController,
                        // cursorColor: CColor.mainColor,
                        style: Font.normal,
                        decoration: InputDecoration(
                          contentPadding: sInsetsAll(0),
                          hintText: '请输入邀请码',
                          hintStyle: Font.hint,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _reasonController,
                    cursorColor: CColor.mainColor,
                    style: Font.normal,
                    maxLength: 200,
                    maxLines: 8,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: CColor.bgGrayColor,
                      contentPadding: sInsetsAll(10),
                      border: InputBorder.none,
                      hintText: '填入你适合联盟的原因，让大家更加了解你...',
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
            )
          : Container(),
    );
  }

  @override
  void initState() {
    _codeController = TextEditingController();
    _reasonController = TextEditingController();
    _store = ImageSelectorStore();
    super.initState();
  }

  @override
  void dispose() {
    _codeController = null;
    _reasonController = null;
    _store = null;
    super.dispose();
  }

  @override
  void onResume() {
    _checkNeedCode();
    super.onResume();
  }

  _commit() {
    if (_needCode && _codeController.text.isEmpty) {
      toast('请填写有效的邀请码');
      return;
    }
    if (_reasonController.text.isEmpty) {
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
        API.applyJoinToAlliance,
        params: {
          'league_id': globalMainStore().allianceId,
          'code': _codeController.text,
          'message': _reasonController.text,
          'images': _store.keys,
        },
        onSuccess: (data) {
          dismissLoading();
          toast(data.msg);
          pop();
          // showDialog(
          //   context: rootKey.currentContext,
          //   builder: (BuildContext context) => InviteCodeView(
          //     code: data.data,
          //     closed: () => pop(),
          //   ),
          //   barrierDismissible: false,
          // );
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

  _checkNeedCode() {
    showLoading();
    http.get(API.isInLevelTow, onSuccess: (data) {
      dismissLoading();
      sState(() {
        _showBody = true;
        _needCode = data.data < 2;
      });
    }, onError: (error) {
      dismissLoading();
      sState(() {
        _showBody = true;
        _needCode = true;
      });
    });
  }
}
