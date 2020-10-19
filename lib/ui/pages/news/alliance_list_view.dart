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
                  afterLoading(http.get(API.canCreateAlliance), seconds: 1)
                      .then((data) {
                    if (data.error)
                      toast('获取权限失败');
                    else {
                      if (data.data == 1)
                        push(CreateAllianceView());
                      else
                        toast('您暂无创建联盟的权限');
                    }
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
                return AllianceCellView(
                  bean: bean,
                  selected: bean.id == globalMainStore.allianceId,
                  onTap: () async {
                    if (globalMainStore.allianceId != bean.id) {
                      await afterLoading(
                        globalMainStore.setAllianceId(bean.id),
                        seconds: 0,
                      );
                      globalMainStore.endDrawer();
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
