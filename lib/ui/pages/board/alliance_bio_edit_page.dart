/*
 * @Project:        snp
 * @Package:        ui.pages.board
 * @FileName:       alliance_bio_edit_page
 * @Create:         2020/10/21 7:53 PM
 * @Description:    
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/store/main_store.dart';

class AllianceBioEditPage extends StatefulWidget {
  final String bio;

  const AllianceBioEditPage({Key key, this.bio}) : super(key: key);

  @override
  _AllianceBioEditPageState createState() => _AllianceBioEditPageState();
}

class _AllianceBioEditPageState extends State<AllianceBioEditPage> {
  TextEditingController _controller;

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
            title: Text('修订简介'),
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
                hintText: '填写联盟简介',
                hintStyle: Font.hint,
              ),
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
    showLoading();
    http.post(
      API.allianceBioEdit,
      params: {
        'league_id': globalMainStore.allianceId,
        'bio': _controller.text,
      },
      onSuccess: (data) {
        dismissLoading();
        toast('联盟简介修订成功');
        popData(true);
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
  }

  @override
  void initState() {
    _controller = TextEditingController(text: widget.bio);
    super.initState();
  }

  @override
  void dispose() {
    _controller = null;
    super.dispose();
  }
}
