/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       stake_dialog
 * @Create:         2020/10/16 7:33 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/beans/alliance_stake_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';

class StakeDialog extends StatefulWidget {
  final AllianceStakeBean bean;

  final int myCapacity;

  const StakeDialog(
    this.bean,
    this.myCapacity, {
    Key key,
  }) : super(key: key);

  @override
  _StakeDialogState createState() => _StakeDialogState();
}

class _StakeDialogState extends BaseState<StakeDialog> {
  int _value = 0, _myCapacity = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sInsetsAll(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: CColor.lightCardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                gap(height: 20),
                Padding(
                  padding: sInsetsHV(20, 0),
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: '您已给 ${widget.bean.nickname}',
                          style: Font.normal,
                        ),
                        TextSpan(
                          text: ' @${widget.bean.username} ',
                          style: Font.minorS,
                        ),
                        TextSpan(
                          text: 'Stake能量',
                          style: Font.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                gap(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _changeValue(-1),
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 40,
                          color: CColor.iconColor,
                        ),
                      ),
                    ),
                    gap(width: 20),
                    Container(
                      width: screenWidth * 0.3,
                      padding: sInsetsHV(0, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: CColor.lineColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        // child: RichText(
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        //   text: TextSpan(
                        //     children: <InlineSpan>[
                        //       TextSpan(
                        //         text: bean.stakeNum.toString(),
                        //         style: bean.stakeNum < 0
                        //             ? Font.redH
                        //             : Font.lightH,
                        //       ),
                        //       TextSpan(
                        //         text: ' 点',
                        //         style: Font.normalL,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        child: Text(
                          _value.toString(),
                          style: _value < 0 ? Font.redH : Font.lightH,
                        ),
                      ),
                    ),
                    gap(width: 20),
                    GestureDetector(
                      onTap: () => _changeValue(1),
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 32,
                          color: CColor.iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
                gap(height: 10),
                Text('您当前剩余可用能量：$_myCapacity'),
                gap(height: 20),
                Divider(),
                Container(
                  height: 45,
                  child: Row(
                    children: [
                      CommonButton(
                        text: '取消',
                        width: (screenWidth - sWidth(40) - 1) / 2,
                        height: 45,
                        radius: 0,
                        elevation: 0,
                        backColor: Colors.transparent,
                        textColor: CColor.minorTextColor,
                        fontSize: sFontSize(16),
                        onClick: pop,
                      ),
                      VerticalDivider(),
                      CommonButton(
                        text: '确定',
                        width: (screenWidth - sWidth(40) - 1) / 2,
                        height: 45,
                        radius: 0,
                        elevation: 0,
                        backColor: Colors.transparent,
                        textColor: CColor.mainColor,
                        fontSize: sFontSize(16),
                        onClick: _doStake,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _changeValue(int value) {
    if (_value.abs() - widget.bean.stakeNum.abs() < widget.myCapacity)
      sState(() {
        _value += value;
        _myCapacity =
            widget.myCapacity - (_value.abs() - widget.bean.stakeNum.abs());
      });
    else
      toast('剩余能量不足');
  }

  _doStake() async {
    if (_value == widget.bean.stakeNum)
      pop();
    else {
      RouteUtil.popWithData(_value, context);
    }
  }

  @override
  void initState() {
    _value = widget.bean.stakeNum;
    _myCapacity = widget.myCapacity;
    super.initState();
  }
}
