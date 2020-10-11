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
import 'package:snp/ui/widgets/avatar_view.dart';
import 'package:snp/ui/widgets/web_image_view.dart';

class AllianceApplyCell extends StatelessWidget {
  final AllianceApplyBean bean;

  const AllianceApplyCell(this.bean, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      padding: sInsetsLTRB(15, 10, 15, 0),
      // alignment: Alignment.center,
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
              bean.message * 20,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: sInsetsHV(25, 5),
            child: Row(
              children: bean.images
                  .map((e) => GestureDetector(
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
                      ))
                  .toList(),
            ),
          ),
          bean.extend.invite == null
              ? Container()
              : Container(
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
                              bean.extend.invite.message * 20,
                              style: Font.minor,
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          WebImage(
                            url: bean.extend.invite.images[0],
                            radius: 5,
                            width: imageSize,
                            height: imageSize,
                            style: Config.oss_style_thumb,
                            margin: sInsetsLTRB(5, 0, 0, 0),
                          ),
                        ],
                      ),
                      gap(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: LinearPercentIndicator(
                              lineHeight: 20.0,
                              percent: 0.9,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: CColor.mainColor,
                              backgroundColor: CColor.bgPartColor,
                              center: Text('+${bean.prestige}'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          Divider(),
        ],
      ),
    );
  }

  double get imageSize => (screenWidth - sWidth((15 + 25) * 2.0 + 10)) / 3;
}
