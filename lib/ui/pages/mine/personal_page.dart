/*
 * @Project:        snp
 * @Package:        ui.pages.mine
 * @FileName:       personal_page
 * @Create:         2020/9/4 10:54 AM
 * @Description:    
 * @author          dt
*/

import 'package:aliossflutter/aliossflutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/oss_util.dart';
import 'package:snp/main.dart';
import 'package:snp/ui/pages/mine/introduction_page.dart';
import 'package:snp/ui/pages/mine/nickname_page.dart';
import 'package:image_selector/image_selector.dart';
import 'package:snp/ui/store/user.dart';
import 'package:snp/ui/widgets/avatar_view.dart';

// ignore: must_be_immutable
class PersonalPage extends StatelessWidget {
  List<String> _items = ['头像', '昵称', '性别', '所在地', '个人简介'];
  List<String> _genders = ['未明确', '男', '女'];
  int _selectedGenderIndex = 0;
  final _store = globalUserStore();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('编辑个人资料'),
        elevation: 2,
      ),
      body: ListView.separated(
        itemBuilder: _renderCell,
        separatorBuilder: (context, index) => Divider(
          indent: index == 0 ? 0 : sWidth(15),
          endIndent: index == 0 ? 0 : sWidth(15),
        ),
        itemCount: _items.length,
      ),
    );
  }

  Widget _renderCell(BuildContext context, int index) {
    if (index == 0)
      return Column(
        children: [
          Container(
            margin: sInsetsHV(0, 20),
            child: Center(
              child: GestureDetector(
                onTap: () => _showAvatarPicker(context),
                child: Stack(
                  children: [
                    Observer(
                      builder: (_) => Avatar(_store.bean.avatar),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ClipOval(
                        child: Container(
                          color: CColor.mainColor,
                          padding: EdgeInsets.all(3),
                          child: Center(
                            child: Icon(
                              SnpIcon.edit,
                              size: 10,
                              color: CColor.overMainTextColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: sInsetsAll(10),
              child: Observer(
                builder: (_) => Text(
                  ObjectUtil.isEmptyString(_store.bean.username)
                      ? ''
                      : '@${_store.bean.username}',
                  style: Font.minorH,
                ),
              ),
            ),
          ),
        ],
      );

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _items[index],
            style: Font.normal,
          ),
          gap(width: 50),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Observer(
                builder: (_) {
                  String _subtitle = '';
                  switch (index) {
                    case 1:
                      _subtitle = _store.bean.nickname;
                      break;
                    case 2:
                      _subtitle = _store.bean.gender == 0
                          ? '女'
                          : (_store.bean.gender == 1 ? '男' : '未明确');
                      _selectedGenderIndex = _genders.indexOf(_subtitle);
                      break;
                    case 3:
                      _subtitle = ObjectUtil.isEmptyString(_store.bean.areaName)
                          ? '未设置'
                          : _store.bean.areaName;
                      break;
                    case 4:
                      _subtitle = ObjectUtil.isEmptyString(_store.bean.disc)
                          ? '暂无简介'
                          : _store.bean.disc;
                      break;
                  }
                  return Text(
                    _subtitle,
                    style: Font.minorS,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      trailing: index != 0
          ? Icon(
              Icons.arrow_forward_ios,
              color: CColor.iconColor,
              size: 15,
            )
          : null,
      onTap: () {
        switch (index) {
          case 1:
            RouteUtil.showModelPage(NicknamePage(asModel: true));
            break;
          case 2:
            _showGenderPicker(context);
            break;
          case 3:
            CityPickers.showCityPicker(
              context: context,
              height: 300,
              barrierOpacity: .3,
              locationCode: ObjectUtil.isEmptyString(_store.bean.areaCode)
                  ? '110000'
                  : _store.bean.areaCode,
            ).then(_setArea);
            break;
          case 4:
            RouteUtil.showModelPage(IntroductionPage());
            break;
        }
      },
    );
  }

  _showGenderPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        color: CColor.bgColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  onPressed: () => pop(),
                  child: Text(
                    '取消',
                    style: Font.light,
                  ),
                ),
                FlatButton(
                  onPressed: () => _setGender(),
                  child: Text(
                    '确定',
                    style: Font.light,
                  ),
                ),
              ],
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 50,
//                useMagnifier: true,
                scrollController: FixedExtentScrollController(
                    initialItem: _selectedGenderIndex),
                onSelectedItemChanged: (index) => _selectedGenderIndex = index,
                children: _genders
                    .map(
                      (e) => Center(
                        child: Text(e),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showAvatarPicker(BuildContext context) {
    RouteUtil.showImagePicker(context).then((value) {
      try {
        if (ObjectUtil.isEmpty(value)) return;
        ImageSelector.selectAvatar(camera: value == 1)
            .then((value) => _uploadImage(value));
      } catch (e) {
        print(e);
      }
    });
  }

  _uploadImage(String path) async {
    showLoading();
    oss.uploadImage(
      path,
      Config.oss_remote_dir_avatar,
      onFinish: (success, key, msg) {
        if (success)
          _setAvatar(key);
        else
          dismissLoading();
      },
    );
//     AliOSSFlutter _oss = AliOSSFlutter();
//     _oss.upload(
//       Config.oss_bucket,
//       path,
//       filename,
// //      callbackBody: Config.callbackBody,
// //      callbackBodyType: Config.callbackBodyType,
// //      callbackHost: Config.callbackHost,
// //      callbackUrl: Config.callbackUrl,
// //      callbackVars: Config.callbackVars,
//     );
//     //监听
//     // _oss.responseFromProgress.listen((data) {
//     //   print(data);
//     // });
//     _oss.responseFromUpload.listen((data) {
//       if (data.success)
//         _setAvatar(data.key);
//       else {
//         dismissLoading();
//         toast('头像上传失败\n${data.msg}');
//       }
//     });
  }

  _setGender() async {
    int _gender = _selectedGenderIndex == 0
        ? 2
        : (_selectedGenderIndex == 2 ? 0 : _selectedGenderIndex);
    bool result = await _store.setGender(_gender);

    if (result) {
      toast('设置成功');
      pop();
    } else
      toast('设置失败,请重试');
  }

  _setArea(Result res) async {
    if (res != null) {
      print(res.toString());
      String _areaName =
          '${res.provinceName} ${res.cityName} ${res.areaName}'.trimRight();
      String _value = '$_areaName|${res.areaId}';

      bool result = await _store.setArea(_value);

      if (result)
        toast('设置成功');
      else
        toast('设置失败,请重试');
    }
  }

  _setAvatar(String key) async {
    bool result = await _store.setAvatar(key);

    dismissLoading();
    if (result)
      toast('设置成功');
    else {
      toast('设置失败,请重试');
      oss.deleteImage(key);
    }
  }
}
