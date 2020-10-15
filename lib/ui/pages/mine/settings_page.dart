/*
 * @Project:        snp
 * @Package:        ui.pages.mine
 * @FileName:       settings_page
 * @Create:         2020/9/3 4:57 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/user_util.dart';
import 'package:snp/ui/pages/mine/store/settings.dart';
import 'package:snp/ui/store/user.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  final SettingsStore _store = SettingsStore();
  List<String> _settingItems = ['导出密码', '清除缓存', '版本更新', '关于我们', '退出登录'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text('设置'),
      ),
      body: ListView.separated(
        itemBuilder: _renderCell,
        separatorBuilder: (context, index) => Divider(
          indent: sWidth(15),
          endIndent: sWidth(15),
        ),
        itemCount: _settingItems.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget _renderCell(BuildContext context, int index) {
    Widget _subtitle = Container();
    if (index == 1) {
      _store.getTempSize();
      _subtitle = Observer(
        builder: (_) => _store.tempSize == null
            ? SpinKitDoubleBounce(
                color: CColor.mainColor,
                size: sWidth(20),
              )
            : Text(
                _store.tempSize,
                style: Font.minorS,
              ),
      );
    } else if (index == 2) {
      _store.getVersion();
      _subtitle = Observer(
        builder: (_) => _store.version == null
            ? SpinKitDoubleBounce(
                color: CColor.mainColor,
                size: sWidth(20),
              )
            : Text(
                _store.version,
                style: Font.minorS,
              ),
      );
    }

    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _settingItems[index],
            style: index == _settingItems.length - 1 ? Font.light : Font.normal,
          ),
          _subtitle,
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: CColor.iconColor,
        size: 15,
      ),
      onTap: () {
        switch (index) {
          case 1:
            _store.emptyTemp(context);
            break;
          case 3:
            afterLoading(null).then((value) => toast('msg'));
            break;
          case 4:
            globalUserStore.logout();
            break;
        }
      },
    );
  }
}
