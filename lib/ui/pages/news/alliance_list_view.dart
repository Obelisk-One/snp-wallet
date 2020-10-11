/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       alliance_list_view
 * @Create:         2020/8/27 5:26 PM
 * @Description:    首页弹出的联盟列表
 * @author          dt
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snp/beans/alliance_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/alliance_cell_view.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';

import 'create_alliance_view.dart';

class AllianceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: sInsetsLTRB(10, statusBarHeight, 10, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "联盟列表",
                style: Font.title,
              ),
              IconButton(
                icon: Icon(Icons.add),
                tooltip: '创建联盟',
                onPressed: () {
                  afterLoading(http.get(API.canCreateAlliance), seconds: 0)
                      .then((data) {
                    if (!data.error)
                      push(CreateAllianceView());
                    else
                      toast(data.msg);
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: SListView(
              apiPath: API.allianceList,
              itemView: (index, item) {
                AllianceBean bean = AllianceBean.fromJson(item);
                MainStore _store = globalMainStore();
                return AllianceCellView(
                  bean: bean,
                  selected: bean.id == _store.allianceId,
                  onTap: () async {
                    if (_store.allianceId != bean.id) {
                      await afterLoading(
                        _store.setAllianceId(bean.id),
                        seconds: 0,
                      );
                      _store.endDrawer();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
