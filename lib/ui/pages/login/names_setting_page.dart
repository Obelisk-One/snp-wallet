/*
 * @Project:        snp
 * @Package:        ui.pages.mine
 * @FileName:       username_page
 * @Create:         2020/9/23 1:11 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/pages/login/register_page.dart';
import 'package:snp/ui/store/user.dart';

class NamesSettingPage extends StatefulWidget {
  const NamesSettingPage({Key key}) : super(key: key);

  @override
  _NamesSettingPageState createState() => new _NamesSettingPageState();
}

class _NamesSettingPageState extends BaseState<NamesSettingPage> {
  TextEditingController _nicknameController, _usernameController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: sInsetsAll(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textField(_usernameController, '唯一用户名'),
              gap(height: 10),
              Text(
                "用户名4-10个字符，支持英文、数字、“-”或减号，用户名是唯一的并一经设置不可修改",
                style: Font.hintS,
              ),
              gap(height: 20),
              _textField(_nicknameController, '请填写你的昵称'),
              gap(height: 10),
              Text(
                "昵称4-16个字符，支持中英文，允许空格及下划线",
                style: Font.hintS,
              ),
              gap(height: 50),
              Center(
                child: CommonButton(
                  text: "注册账户",
                  onClick: _doRegister,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textField(TextEditingController controller, String hint) {
    bool _didInput = controller.text.isNotEmpty;
    return TextField(
      controller: controller,
      // autofocus: true,
      cursorColor: CColor.mainColor,
      style: Font.normal,
      decoration: InputDecoration(
        contentPadding: sInsetsHV(0, 10),
        hintText: hint,
        hintStyle: Font.hint,
        prefixText: _didInput && hint.contains('联盟') ? '@ ' : '',
        suffixIcon: Visibility(
          visible: _didInput,
          child: GestureDetector(
            onTap: () => sState(() => controller.text = ''),
            child: Padding(
              padding: sInsetsAll(15, sc: false),
              child: ClipOval(
                child: Container(
                  color: CColor.coverColor,
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: CColor.overMainTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onChanged: (text) => sState(() {}),
    );
  }

  _doRegister() async {
    if (_usernameController.text.isEmpty) {
      toast('请输入用户名');
      return;
    }
    if (_nicknameController.text.isEmpty) {
      toast('请输入昵称');
      return;
    }
    await globalUserStore.doRegister(
      _usernameController.text,
      _nicknameController.text,
    );
    if (globalUserStore.password.isNotEmpty)
      push(RegisterPage(globalUserStore.password));
  }

  @override
  void initState() {
    _nicknameController = TextEditingController();
    _usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nicknameController = null;
    _usernameController = null;
    super.dispose();
  }
}
