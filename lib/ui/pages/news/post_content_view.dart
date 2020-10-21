/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       post_content_view
 * @Create:         2020/9/18 9:31 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/beans/content_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/event_bus_util.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/image_selector_view.dart';

class PostContentPage extends StatelessWidget {
  final ContentBean replyBean;

  PostContentPage({Key key, this.replyBean}) : super(key: key);

  final _controller = TextEditingController();
  final _store = ImageSelectorStore()
    ..setTargetDir(Config.oss_remote_dir_content);

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
                  onClick: _commit,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: sInsetsHV(10, 0),
            child: replyBean != null
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: '回复给 ',
                          style: Font.hint,
                        ),
                        TextSpan(
                          text: '@${replyBean.username}',
                          style: Font.light,
                        ),
                      ],
                    ),
                  )
                : gap(),
          ),
          gap(height: 10),
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
              hintText: '请分享你的见解...',
              hintStyle: Font.hint,
            ),
          ),
          gap(height: 20),
          ImageSelectorView(
            store: _store,
            maxImage: 3,
          ),
        ],
      ),
    );
  }

  _commit() {
    if (_controller.text.isEmpty) {
      toast('请填写分享的内容');
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
      Map<String, dynamic> _params = {};
      if (replyBean == null)
        _params = {
          'league_id': globalMainStore.allianceId,
          'message': _controller.text,
          'images': _store.keys,
        };
      else
        _params = {
          'league_id': globalMainStore.allianceId,
          'dynamic_id': replyBean.id,
          'message': _controller.text,
          'images': _store.keys,
        };
      http.post(
        replyBean == null ? API.postContent : API.postComment,
        params: _params,
        onSuccess: (data) {
          dismissLoading();
          toast('提交成功');
          if (replyBean == null)
            pop();
          else
            popData(replyBean);
          bus.emit(Config.event_bus_posted_content, replyBean == null);
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
