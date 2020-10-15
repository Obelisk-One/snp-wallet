/*
 * @Project:        snp
 * @Package:        ui.pages
 * @FileName:       alliance_select_page
 * @Create:         2020/9/23 4:41 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/beans/alliance_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/pages/main_page.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/alliance_cell_view.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';

class AllianceSelectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择感兴趣的联盟'),
      ),
      body: Padding(
        padding: sInsetsAll(20),
        child: SListView(
          apiPath: API.allianceList,
          itemView: (index, item) {
            AllianceBean bean = AllianceBean.fromJson(item);
            return AllianceCellView(
              bean: bean,
              showApply: false,
              onTap: () {
                globalMainStore.setAllianceId(bean.id);
                RouteUtil.pushAndRemoveUntil(MainPage(), context);
              },
            );
          },
        ),
      ),
    );
  }
}
