/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       post_content_view
 * @Create:         2020/9/18 9:31 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/widgets/image_selector_view.dart';

class PostContentPage extends StatelessWidget {
  final String replyUser;

  PostContentPage({Key key, this.replyUser}) : super(key: key);

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
            actions: [
              UnconstrainedBox(
                child: CommonButton(
                  text: '发送',
                  radius: sHeight(12.5),
                  width: sWidth(60),
                  height: sHeight(25),
                  margin: sInsetsLTRB(0, 0, 15, 0),
                  fontSize: sFontSize(14),
                  // isDisable: !_canSubmit,
                  disableBackColor: CColor.disableColor,
                  onClick: () {},
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !ObjectUtil.isEmptyString(replyUser),
            child: Container(
              margin: sInsetsHV(10, 0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: '回复给 ',
                      style: Font.hint,
                    ),
                    TextSpan(
                      text: '@$replyUser',
                      style: Font.light,
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextField(
            controller: _controller,
            cursorColor: CColor.mainColor,
            style: Font.light,
            maxLength: 200,
            maxLines: 5,
            decoration: InputDecoration(
              contentPadding: sInsetsAll(10),
              border: InputBorder.none,
              hintText: '请分享你的见解...',
              hintStyle: Font.hint,
            ),
          ),
          gap(height: 20),
          ImageSelectorView(store: _store),
        ],
      ),
    );
  }
}
