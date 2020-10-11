/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       alliance_cell_view
 * @Create:         2020/9/23 4:43 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/beans/alliance_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/pages/news/apply_join_page.dart';
import 'package:snp/ui/widgets/web_image_view.dart';

class AllianceCellView extends StatelessWidget {
  final AllianceBean bean;
  final VoidCallback onTap;
  final bool showApply, selected;

  AllianceCellView({
    Key key,
    @required this.bean,
    this.onTap,
    this.showApply = true,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: WebImage(
        url: bean.flagPic,
        margin: sInsetsHV(0, 5),
        height: sHeight(90),
        radius: 10,
        overView: _contentView(),
      ),
      // child: CachedNetworkImage(
      //   imageUrl: bean.flagPic+'_org11',
      //   imageBuilder: (context, imageProvider) => Container(
      //     height: sHeight(90),
      //     margin: sInsetsHV(0, 5),
      //     decoration: BoxDecoration(
      //       // shape: BoxShape.circle,
      //       borderRadius: BorderRadius.circular(10),
      //       image: DecorationImage(
      //         image: imageProvider,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     child: _contentView(),
      //   ),
      //   placeholder: (context, url) => _placeHolderView(
      //     Stack(
      //       children: [
      //         Center(
      //           child: SpinKitDoubleBounce(
      //             color: CColor.mainColor,
      //             size: sWidth(50),
      //           ),
      //         ),
      //         _contentView(),
      //       ],
      //     ),
      //   ),
      //   errorWidget: (context, url, error) => _placeHolderView(_contentView()),
      // ),
    );
  }

  Widget _contentView() => Container(
        padding: sInsetsAll(10, sc: false),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CColor.coverColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: sHeight(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: selected,
                    child: Icon(
                      Icons.check,
                      size: 20,
                      color: CColor.overMainTextColor,
                    ),
                  ),
                  !bean.exist && showApply
                      ? CommonButton(
                          text: '申请加入',
                          textColor: CColor.overMainTextColor,
                          fontSize: sFontSize(12),
                          borderWidth: 1,
                          borderColor: CColor.overMainTextColor,
                          radius: 20,
                          backColor: Colors.transparent,
                          width: sWidth(70),
                          height: sHeight(23),
                          elevation: 0,
                          onClick: () => RouteUtil.showModelPage(ApplyJoinPage()),
                        )
                      : Text(
                          bean.exist ? '已加入' : '',
                          style: Font.overMainS,
                        ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  bean.name,
                  style: TextStyle(
                    color: CColor.overMainTextColor,
                    fontSize: sFontSize(14),
                  ),
                ),
              ),
            ),
            Container(
              height: sHeight(25),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '${bean.count} 位成员',
                  style: Font.overMainS,
                ),
              ),
            ),
          ],
        ),
      );
}
