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

class _ContentDetailPageState extends State<ContentDetailPage> {
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
          margin: sInsetsLTRB(0, index == 0 ? 0 : 10, 0, 0),
          onClick: (id) => push(ContentDetailPage(id: id)),
        ),
      ),
    );
  }

  _contentLine() {
    return Observer(
      builder: (_) => Column(
        children: _store.contentLine
            .map<Widget>((e) => ContentCell(
                  bean: e,
                  showFull: true,
                  showLine: true,
                  canReply: false,
                  isFirst: _store.contentLine.first.id == e.id,
                  isLast: _store.contentLine.last.id == e.id,
                ))
            .toList()
              ..add(Divider())
              ..add(
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: sInsetsHV(10, 5),
                    child: Text('评论列表'),
                  ),
                ),
              )
              ..add(Divider())
              ..add(_controller.dataLength <= 0
                  ? SizedBox(
                      height: sHeight(200),
                      child: EmptyListView(
                        msg: '暂无评论,快来抢占沙发',
                        onRefresh: () => _controller.callRefresh(),
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
