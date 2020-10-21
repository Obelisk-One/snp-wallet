/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       alliance_apply_cell_view
 * @Create:         2020/10/11 1:46 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:image_selector/image_selector.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:snp/beans/alliance_apply_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/store/main_store.dart';
import 'package:snp/ui/widgets/avatar_view.dart';
import 'package:snp/ui/widgets/web_image_view.dart';

typedef VoteCallBack = void Function(int dataId);

class AllianceApplyCell extends StatelessWidget {
  final AllianceApplyBean bean;
  final Function onVote;

  const AllianceApplyCell(
    this.bean, {
    this.onVote,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: sInsetsLTRB(15, 10, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(
                bean.avatar,
                size: 20,
              ),
              gap(width: 5),
              RichText(
                // textAlign: TextAlign.center,
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                      text: '${bean.nickname} ',
                      style: Font.normal,
                    ),
                    TextSpan(
                      text:
                          '${bean.username.isEmpty ? '' : '@${bean.username}'} 申请加入',
                      style: Font.minor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: sInsetsLTRB(25, 10, 10, 5),
            child: Text(
              bean.message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: sInsetsHV(25, 5),
            child: Row(
              children: bean.images
                  .map(
                    (e) => GestureDetector(
                      onTap: () => ImageSelector.previewWebImages(
                        bean.images.indexOf(e),
                        bean.images,
                      ),
                      child: WebImage(
                        url: e,
                        radius: 5,
                        width: imageSize,
                        height: imageSize,
                        style: Config.oss_style_thumb,
                        margin: sInsetsLTRB(
                          bean.images.first == e ? 0 : 5,
                          0,
                          0,
                          0,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          bean.extend.type.toLowerCase() == 'invite' &&
                  bean.extend.invite != null
              ? Container(
                  margin: sInsetsLTRB(0, 5, 0, 10),
                  padding: sInsetsHV(25, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CColor.bgGrayColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Avatar(
                            bean.avatar,
                            size: 20,
                          ),
                          gap(width: 5),
                          Text(
                            '${bean.extend.invite.nickname} ${bean.extend.invite.username.isEmpty ? '' : '@${bean.extend.invite.username}'} 推荐',
                            style: Font.minor,
                          ),
                        ],
                      ),
                      gap(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              bean.extend.invite.message,
                              style: Font.minor,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => ImageSelector.previewWebImages(
                              0,
                              [bean.extend.invite.images[0]],
                            ),
                            child: WebImage(
                              url: bean.extend.invite.images[0],
                              radius: 5,
                              width: imageSize,
                              height: imageSize,
                              style: Config.oss_style_thumb,
                              margin: sInsetsLTRB(5, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                      gap(height: 10),
                      _progress,
                    ],
                  ),
                )
              : bean.extend.type.toLowerCase() == 'league' &&
                      bean.extend.league.isNotEmpty
                  ? Container(
                      margin: sInsetsLTRB(0, 5, 0, 10),
                      padding: sInsetsHV(25, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CColor.bgGrayColor,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Avatar(
                                bean.avatar,
                                size: 20,
                              ),
                              gap(width: 5),
                              Text(
                                '${bean.nickname} ${bean.username.isEmpty ? '' : '@${bean.username}'} 是以下联盟成员',
                                style: Font.minor,
                              ),
                            ],
                          ),
                          gap(height: 5),
                          Column(
                            children: bean.extend.league.map((e) {
                              return Container(
                                margin: sInsetsLTRB(0, 0, 0, 10),
                                child: Row(
                                  children: [
                                    Avatar(
                                      e.flagPic,
                                      size: 30,
                                    ),
                                    gap(width: 10),
                                    RichText(
                                      text: TextSpan(
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '${e.name}\n',
                                            style: Font.normalL,
                                          ),
                                          TextSpan(
                                            text: '声誉：',
                                            style: Font.minorS,
                                          ),
                                          TextSpan(
                                            text: e.prestige.toString(),
                                            style: Font.normalL,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                          _progress,
                        ],
                      ),
                    )
                  : Container(),
          Divider(),
        ],
      ),
    );
  }

  get _progress => Row(
        children: [
          Expanded(
            child: LinearPercentIndicator(
              lineHeight: 20.0,
              percent: bean.prestige / bean.totalPrestige,
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: CColor.mainColor,
              backgroundColor: CColor.bgPartColor,
              center: Text(
                bean.state == 1
                    ? (bean.prestige / bean.totalPrestige * 100)
                            .toStringAsFixed(2) +
                        '%'
                    : '+' + bean.prestige.toString(),
                style: ts(
                  c: Colors.white,
                ),
              ),
            ),
          ),
          gap(width: 5),
          if (bean.state == 1)
            Text('已通过')
          else
            Observer(
              builder: (_) => Visibility(
                visible: globalMainStore.isInAlliance,
                child: GestureDetector(
                  onTap: () {
                    if (onVote != null) onVote();
                  },
                  child: Icon(
                    SnpIcon.vote,
                    size: 20,
                    color: CColor.iconColor,
                  ),
                ),
              ),
            ),
        ],
      );

  double get imageSize => (screenWidth - sWidth((15 + 25) * 2.0 + 10)) / 3;
}
