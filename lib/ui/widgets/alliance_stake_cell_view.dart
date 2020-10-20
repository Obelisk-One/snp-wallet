/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       alliance_stake_cell
 * @Create:         2020/10/16 3:58 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/beans/alliance_stake_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/store/user.dart';
import 'package:snp/ui/widgets/avatar_view.dart';
import 'package:snp/ui/widgets/stake_dialog.dart';

typedef FinishCallBack = void Function(int value, int userId);

class AllianceStakeCell extends StatelessWidget {
  final AllianceStakeBean bean;
  final int myCapacity;
  final FinishCallBack onConfirm;

  const AllianceStakeCell(
    this.bean,
    this.myCapacity, {
    this.onConfirm,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: sInsetsLTRB(15, 10, 15, 0),
      child: Row(
        children: [
          Avatar(
            bean.avatar,
            size: 40,
          ),
          gap(width: 10),
          Expanded(
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: bean.nickname,
                    style: Font.normal,
                  ),
                  TextSpan(
                    text: ' 共获得 ',
                    style: Font.minorXS,
                  ),
                  TextSpan(
                    text: bean.stakeTotal.toString(),
                    style: bean.stakeTotal < 0 ? Font.redL : Font.lightL,
                  ),
                  TextSpan(
                    text: ' 点能量，您已投 ',
                    style: Font.minorXS,
                  ),
                  TextSpan(
                    text: bean.stakeNum.toString(),
                    style: bean.stakeNum < 0 ? Font.redL : Font.lightL,
                  ),
                  TextSpan(
                    text: ' 点能量',
                    style: Font.minorXS,
                  ),
                ],
              ),
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     RichText(
            //       text: TextSpan(
            //         children: <InlineSpan>[
            //           TextSpan(
            //             text: bean.nickname,
            //             style: Font.normal,
            //           ),
            //           TextSpan(
            //             text: '共获得',
            //             style: Font.minorS,
            //           ),
            //           TextSpan(
            //             text: bean.stakeTotal.toString(),
            //             style: Font.lightL,
            //           ),
            //           TextSpan(
            //             text: '点能量，您已投',
            //             style: Font.minorS,
            //           ),
            //           TextSpan(
            //             text: bean.stakeNum.toString(),
            //             style: Font.lightL,
            //           ),
            //           TextSpan(
            //             text: '点能量',
            //             style: Font.minorS,
            //           ),
            //         ],
            //       ),
            //     ),
            //     gap(height: 5),
            //     LinearPercentIndicator(
            //       lineHeight: 20.0,
            //       percent: bean.prestige / bean.totalPrestige,
            //       linearStrokeCap: LinearStrokeCap.roundAll,
            //       progressColor: CColor.mainColor,
            //       backgroundColor: CColor.bgPartColor,
            //     ),
            //   ],
            // ),
          ),
          gap(width: globalMainStore.isInAlliance ? 5 : 0),
          globalMainStore.isInAlliance
              ? IconButton(
                  icon: Icon(SnpIcon.stake),
                  iconSize: 20,
                  color: CColor.iconColor,
                  padding: sInsetsAll(0),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  constraints: BoxConstraints(
                    maxWidth: 40,
                    maxHeight: 40,
                  ),
                  onPressed: () => _showStakeDialog(context),
                )
              : gap(),
        ],
      ),
    );
  }

  _showStakeDialog(BuildContext context) {
    if (bean.username == globalUserStore.bean.username) {
      toast('无法对自己进行Stake');
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StakeDialog(bean, myCapacity),
    ).then((value) {
      if (onConfirm != null && value != null) onConfirm(value, bean.userId);
    });
  }
}
