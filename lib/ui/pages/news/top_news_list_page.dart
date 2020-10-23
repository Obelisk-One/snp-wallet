/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       hottest_new_list_page
 * @Create:         2020/8/27 3:10 PM
 * @Description:    动态排行
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:snp/beans/content_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/pages/news/content_detail_page.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/content_cell_view.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';

class TopNewsList extends StatefulWidget {
  @override
  _TopNewsListState createState() => _TopNewsListState();
}

class _TopNewsListState extends State<TopNewsList> {
  Widget _body;

  @override
  Widget build(BuildContext context) {
    //TODO 在push或pop的时候会重复调用build方法,导致ListView重复调用接口刷新数据,暂时未找到解决方案,先在initState中实例化ListView
    return _body;
    // return SListView(
    //   key: Key('FreshNewList'),
    //   apiPath: API.topContent,
    //   params: {'league_id': globalMainStore.allianceId},
    //   backColor: CColor.bgGrayColor,
    //   itemView: (index, item) => ContentCell(
    //     bean: ContentBean.fromJson(item),
    //     margin: sInsetsLTRB(0, index == 0 ? 0 : 10, 0, 0),
    //     onClick: (id) => push(ContentDetailPage(id: id)),
    //   ),
    // );
  }

  @override
  void initState() {
    _body = SListView(
      key: Key('FreshNewList'),
      apiPath: API.topContent,
      params: {'league_id': globalMainStore.allianceId},
      backColor: CColor.bgGrayColor,
      itemView: (index, item) => ContentCell(
        bean: ContentBean.fromJson(item),
        margin: sInsetsLTRB(0, index == 0 ? 0 : 10, 0, 0),
        onClick: (id) => push(ContentDetailPage(id: id)),
      ),
    );
    super.initState();
  }
}
