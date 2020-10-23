/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       content_detail_page
 * @Create:         2020/10/20 5:28 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/beans/content_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/pages/news/post_content_view.dart';
import 'package:snp/ui/pages/news/store/content_detail.dart';
import 'package:snp/ui/widgets/content_cell_view.dart';
import 'package:snp/ui/widgets/empty_list_view.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';

class ContentDetailPage extends StatefulWidget {
  final int id;

  ContentDetailPage({Key key, @required this.id})
      : assert(id != null),
        super(key: key);

  @override
  _ContentDetailPageState createState() => _ContentDetailPageState();
}

class _ContentDetailPageState extends BaseState<ContentDetailPage> {
  ContentDetailStore _store;
  SListViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('对话'),
        elevation: 2,
      ),
      body: SListView(
        controller: _controller,
        apiPath: API.comments,
        params: <String, dynamic>{'dynamic_id': widget.id},
        onRefresh: () => _store.fetchContentLine(widget.id),
        showEmpty: false,
        header: _contentLine(),
        itemView: (index, item) => ContentCell(
          bean: ContentBean.fromJson(item),
          showBottomLine: true,
          margin: sInsetsLTRB(0, index == 0 ? 0 : 10, 0, 0),
          onClick: (id) => push(ContentDetailPage(id: id)),
        ),
      ),
    );
  }

  _contentLine() {
    return Observer(
      builder: (_) => Column(
        children: _store.contentLine.map<Widget>((e) {
          bool _isLast = _store.contentLine.last.id == e.id;
          bool _isFirst = _store.contentLine.first.id == e.id;
          return ContentCell(
            bean: e,
            showFull: true,
            showLine: true,
            canReply: _isLast,
            isFirst: _isFirst,
            isLast: _isLast,
          );
        }).toList()
          ..add(Divider())
          ..add(
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: sInsetsHV(10, 5),
                child: Text(
                  '评论列表',
                  style: Font.normal,
                ),
              ),
            ),
          )
          ..add(Divider())
          ..add(_controller.dataLength <= 0 && _store.contentLine.length > 0
              ? SizedBox(
                  height: sHeight(200),
                  child: EmptyListView(
                    marginTop: 60,
                    smallIcon: true,
                    buttonText: '立即评论',
                    msg: '暂无评论,快来抢占沙发',
                    onClick: () => RouteUtil.showModelPage(
                      PostContentPage(replyBean: _store.contentLine.last),
                      (data) {
                        if (data != null && data is ContentBean)
                          _controller.callRefresh();
                      },
                    ),
                  ),
                )
              : gap()),
      ),
    );
  }

  @override
  void initState() {
    _store = ContentDetailStore();
    _controller = SListViewController();
    super.initState();
  }

  @override
  void dispose() {
    _store = null;
    _controller = null;
    super.dispose();
  }
}
