/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       create_alliance_view
 * @Create:         2020/9/18 1:03 PM
 * @Description:    
 * @author          dt
*/

import 'dart:io';

import 'package:aliossflutter/aliossflutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_selector/image_selector.dart';
import 'package:provider/provider.dart';
import 'package:snp/beans/user_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/oss_util.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/pages/news/user_list_view.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/user_cell_view.dart';

class CreateAllianceView extends StatefulWidget {
  @override
  _CreateAllianceViewState createState() => _CreateAllianceViewState();
}

class _CreateAllianceViewState extends BaseState<CreateAllianceView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _tokenController = TextEditingController();

  List _selectedUsers = [];
  String _selectedImage;
  MainStore _mainStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('创建联盟'),
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  gap(height: 50),
                  GestureDetector(
                    onTap: _showImagePicker,
                    child: Container(
                      width: sWidth(60),
                      height: sWidth(60) / Config.allianceImageRatio,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: CColor.bgPartColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ObjectUtil.isEmptyString(_selectedImage)
                          ? Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 25,
                                color: CColor.iconColor,
                              ),
                            )
                          : Image.file(
                              File(_selectedImage),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  gap(height: 10),
                  Text(
                    '点击设置联盟旗帜',
                    style: Font.hint,
                  ),
                  gap(height: 50),
                  Container(
                    margin: sInsetsHV(20, 0),
                    child: Row(
                      children: [
                        Text(
                          '联盟名称',
                          style: Font.minor,
                        ),
                        gap(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            cursorColor: CColor.mainColor,
                            // style: Font.light,
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              contentPadding: sInsetsAll(0),
                              border: InputBorder.none,
                              hintText: '最多16个字符,不能包含特殊字符',
                              hintStyle: Font.hint,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: sWidth(20),
                    endIndent: sWidth(20),
                  ),
                  gap(height: 20),
                  Container(
                    margin: sInsetsHV(20, 0),
                    child: Row(
                      children: [
                        Text(
                          'Token名称',
                          style: Font.minor,
                        ),
                        gap(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _tokenController,
                            cursorColor: CColor.mainColor,
                            // style: Font.light,
                            textAlign: TextAlign.end,
                            textCapitalization: TextCapitalization.characters,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z]'),
                                //RegExp("[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]"),
                              ),
                              LengthLimitingTextInputFormatter(8),
                            ],
                            decoration: InputDecoration(
                              contentPadding: sInsetsAll(0),
                              border: InputBorder.none,
                              hintText: '只能为大写字母,3-8个字符',
                              hintStyle: Font.hint,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: sWidth(20),
                    endIndent: sWidth(20),
                  ),
                  gap(height: 20),
                  CommonButton(
                    margin: sInsetsHV(30, 0),
                    textColor: CColor.mainColor,
                    backColor: CColor.cardColor,
                    borderColor: CColor.mainColor,
                    borderWidth: 1,
                    elevation: 0,
                    child: Text(
                      '选择初始成员',
                      style: Font.light,
                    ),
                    onClick: () => RouteUtil.pushAndReturn(
                      UserListView(
                        selected: _selectedUsers,
                        selection: true,
                        maxSelection: 6,
                      ),
                      context,
                    ).then((value) {
                      if (value != null) sState(() => _selectedUsers = value);
                    }),
                  ),
                  gap(height: 10),
                  Text(
                    '* 最多可选择6名初始成员',
                    style: Font.hintS,
                  ),
                  gap(height: 10),
                  Divider(),
                  Container(
                    height: UserCell.height * (_selectedUsers.length + 1),
                    child: ListView.separated(
                      itemBuilder: (context, index) =>
                          UserCell(_selectedUsers[index]),
                      separatorBuilder: (context, index) => Divider(
                        indent: sWidth(15),
                        endIndent: sWidth(15),
                      ),
                      itemCount: _selectedUsers.length,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              width: screenWidth,
              child: CommonButton(
                text: '创建',
                margin: sInsetsHV(30, 10),
                onClick: () {
                  if (_verifyInput()) {
                    showLoading();
                    oss.uploadImage(
                      _selectedImage,
                      Config.oss_remote_dir_alliance,
                      onFinish: (success, key, msg) {
                        if (success)
                          _createAlliance(key);
                        else
                          dismissLoading();
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _verifyInput() {
    if (ObjectUtil.isEmptyString(_selectedImage)) {
      toast('请设置联盟旗帜');
      return false;
    } else if (ObjectUtil.isEmptyString(_nameController.text)) {
      toast('请设置联盟名称');
      return false;
    } else if (ObjectUtil.isEmptyString(_tokenController.text)) {
      toast('请设置Token名称');
      return false;
    }
    return true;
  }

  _showImagePicker() {
    RouteUtil.showImagePicker(context).then((value) {
      try {
        if (ObjectUtil.isEmpty(value)) return;
        ImageSelector.selectAvatar(
          camera: value == 1,
          needCut: true,
          cutRatio: Config.allianceImageRatio,
        ).then((list) {
          sState(() => _selectedImage = list);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  _createAlliance(String imageKey) {
    List<int> userIds = [];
    _selectedUsers.forEach((e) => userIds.add(e.id));
    http.post(
      API.createAlliance,
      params: {
        'flag_pic': imageKey,
        'name': _nameController.text,
        'token_id': _tokenController.text,
        'team': userIds,
      },
      onSuccess: (data) {
        dismissLoading();
        toast('联盟创建成功!');
        RouteUtil.popToRoot(context);
        _mainStore.openDrawer();
      },
      onError: (error) {
        print("============================");
        oss.deleteImage(imageKey);
        print("============================");
        dismissLoading();
        toast('联盟创建失败!\n${error.msg}');
      },
    );
  }

  @override
  void initState() {
    _mainStore = globalMainStore();
    super.initState();
  }

  @override
  void dispose() {
    _tokenController = null;
    _nameController = null;
    _mainStore = null;
    super.dispose();
  }
}
