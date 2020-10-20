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

class TopNewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => SListView(
        apiPath: API.topContent,
        params: {'league_id': globalMainStore.allianceId},
        backColor: CColor.bgGrayColor,
        itemView: (index, item) => ContentCell(
          bean: ContentBean.fromJson(item),
          margin: sInsetsLTRB(0, index == 0 ? 0 : 10, 0, 0),
          onClick: (id) => push(ContentDetailPage(id: id)),
        ),
      ),
    );
  }
}
