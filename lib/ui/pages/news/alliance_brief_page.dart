/*
 * @Project:        snp
 * @Package:        ui.pages.news
 * @FileName:       alliance_brief_page
 * @Create:         2020/9/24 12:37 AM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/avatar_view.dart';
import 'package:snp/ui/widgets/snp_list_view.dart';
import 'package:snp/ui/widgets/tab_view.dart';

class AllianceBriefPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('今日简报'),
        elevation: 2,
      ),
      body: TabView(
        // tabMargin: sInsetsLTRB(10, 10, 10, 0),
        tabsAlignLeft: true,
        tabs: ['联盟消息', '我的消息'],
        views: <Widget>[
          SListView(
            apiPath: API.allianceBrief,
            params: {'league_id': globalMainStore().allianceId},
            itemView: (index, item) => _renderBriefItem(item),
          ),
          SListView(
            apiPath: API.allianceMineMessage,
            params: {'league_id': globalMainStore().allianceId},
            itemView: (index, item) => _renderBriefItem(item),
          ),
        ],
      ),
    );
  }

  _renderBriefItem(List item) {
    return Container(
      margin: sInsetsLTRB(10, 10, 10, 0),
      padding: sInsetsAll(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CColor.lineColor,
          width: 1,
        ),
      ),
      child: RichText(
        textHeightBehavior: TextHeightBehavior(
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: true,
        ),
        text: TextSpan(
          children: item.map((e) => _renderSpan(e)).toList(),
        ),
      ),
    );
  }

  InlineSpan _renderSpan(item) {
    //块类型(0:普通字符 1:用户名 2:数值)
    int _type = int.parse(item['t'].toString());
    String _text = item['v'].toString();
    if (_type == 1) {
      String _avatar = item['a'].toString();
      return TextSpan(
        style: TextStyle(height: 2.5),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () => print(_text),
              child: Container(
                padding: sInsetsHV(5, 3, sc: false),
                decoration: BoxDecoration(
                  color: CColor.bgGrayColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Avatar(
                      _avatar,
                      size: 20,
                    ),
                    Text(
                      ' @$_text',
                      style: Font.light,
                    ),
                  ],
                ),
              ),
            ),
          ),
          TextSpan(text: '  '),
        ],
      );
    } else {
      TextStyle _style = _type == 0
          ? Font.normal
          : TextStyle(
              color: CColor.red,
              fontSize: sFontSize(16),
            );
      return TextSpan(
        children: [
          TextSpan(
            text: _text,
            style: _style,
          ),
          TextSpan(text: '  '),
        ],
      );
      // return TextSpan(
      //   children: [
      //     WidgetSpan(
      //       child: Container(
      //         child: Text(
      //           _text,
      //           style: _style,
      //         ),
      //       ),
      //     ),
      //     TextSpan(text: '  '),
      //   ],
      // );
    }
  }
}
