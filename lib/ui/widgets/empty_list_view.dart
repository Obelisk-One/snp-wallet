/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       list_empty_view
 * @Create:         2020/8/27 8:59 PM
 * @Description:    无数据页面
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';

class EmptyListView extends StatelessWidget {
  ///显示类型:0显示错误,其他显示空数据
  final int type;
  final String msg;
  final Function onRefresh;

  const EmptyListView({
    Key key,
    this.msg = '空空如也~',
    this.type = 1,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isError = type == 0;
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(),
            flex: 1,
          ),
          SizedBox(
            width: double.infinity,
            height: sHeight(100),
            child: Icon(
              _isError ? SnpIcon.load_error : SnpIcon.no_data,
              size: sFontSize(_isError ? 60 : 80),
              color: CColor.hintTextColor,
            ),
          ),
          gap(height: 10),
          Padding(
            padding: sInsetsHV(20, 0),
            child: Text(
              msg,
              style: Font.hintL,
              textAlign: TextAlign.center,
            ),
          ),
          gap(height: 10),
          CommonButton(
            text: '刷新',
            width: sWidth(100),
            height: sHeight(30),
            borderColor: CColor.hintTextColor,
            borderWidth: 1,
            fontSize: sFontSize(14),
            textColor: CColor.hintTextColor,
            elevation: 0,
            radius: 10,
            backColor: CColor.cardColor,
            onClick: () async {
              if (onRefresh != null) {
                // afterLoading(onRefresh());
                showLoading();
                await onRefresh();
                dismissLoading();
              }
            },
          ),
          Expanded(
            child: SizedBox(),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
