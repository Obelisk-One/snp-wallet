/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       fresh_new_list_page
 * @Create:         2020/8/27 3:08 PM
 * @Description:    首页最新动态
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';

class FreshNewListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => SListView(
        apiPath: API.allianceList + '/${globalMainStore.allianceId}',
        itemView: (index, item) => Container(
          height: sHeight(80),
          margin: sInsetsHV(0, 5),
          color: CColor.disableColor,
          child: Center(
            child: Text(item['id'].toString()),
          ),
        ),
      ),
    );
  }
}
