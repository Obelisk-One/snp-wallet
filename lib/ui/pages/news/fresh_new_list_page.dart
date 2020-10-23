/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       fresh_new_list_page
 * @Create:         2020/8/27 3:08 PM
 * @Description:    首页最新动态
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:snp/beans/content_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/event_bus_util.dart';
import 'package:snp/ui/pages/news/content_detail_page.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/content_cell_view.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';

class FreshNewList extends StatefulWidget {
  const FreshNewList({Key key}) : super(key: key);

  @override
  _FreshNewListState createState() => _FreshNewListState();
}

class _FreshNewListState extends State<FreshNewList> {
  SListViewController _controller;
  Widget _body;

  @override
  Widget build(BuildContext context) {
    //TODO 在push或pop的时候会重复调用build方法,导致ListView重复调用接口刷新数据,暂时未找到解决方案,先在initState中实例化ListView
    return _body;
    // return SListView(
    //   key: Key('FreshNewList'),
    //   controller: _controller,
    //   apiPath: API.newestContent,
    //   params: {'league_id': globalMainStore.allianceId},
    //   backColor: CColor.bgGrayColor,
    //   itemView: (index, item) => ContentCell(
    //     bean: ContentBean.fromJson(item),
    //     margin: sInsetsLTRB(0, index == 0 ? 0 : 10, 0, 0),
    //     onClick: (id) => RouteUtil.push(ContentDetailPage(id: id), context),
    //   ),
    // );
  }

  @override
  void initState() {
    _controller = SListViewController();
    bus.on(
      Config.event_bus_posted_content,
      (arg) {
        if (arg) _controller.callRefresh();
      },
    );

    _body = SListView(
      key: Key('FreshNewList'),
      controller: _controller,
      apiPath: API.newestContent,
      params: {'league_id': globalMainStore.allianceId},
      backColor: CColor.bgGrayColor,
      itemView: (index, item) => ContentCell(
        bean: ContentBean.fromJson(item),
        margin: sInsetsLTRB(0, index == 0 ? 0 : 10, 0, 0),
        onClick: (id) => RouteUtil.push(ContentDetailPage(id: id), context),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller = null;
    bus.off(Config.event_bus_posted_content);
    super.dispose();
  }
}
