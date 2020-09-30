/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       user_cell_view
 * @Create:         2020/9/21 9:37 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:snp/beans/user_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/widgets/avatar_view.dart';

class UserCell extends StatelessWidget {
  final bool selection;
  final bool selected;
  final UserBean bean;
  final Function onTap;

  const UserCell(
    this.bean, {
    Key key,
    this.selection = false,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar(
        bean.avatar,
        size: 50,
      ),
      title: Text(bean.nickname),
      subtitle: Text(
        '@${bean.username}',
        style: Font.minorS,
      ),
      trailing: selection
          ? Icon(
              !this.selected ? Icons.add_box_outlined : Icons.check_box_rounded,
              color: !this.selected ? CColor.minorTextColor : CColor.mainColor,
              size: 22,
            )
          : null,
      onTap: onTap,
    );

    // return Container(
    //   padding: sInsetsAll(10),
    //   child: Row(
    //     children: [
    //       Avatar(bean.avatar),
    //       gap(width: 10),
    //       Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(bean.nickname),
    //             gap(height: 5),
    //             Text(
    //               '@${bean.username}',
    //               style: Font.minorS,
    //             ),
    //           ],
    //         ),
    //       ),
    //       Icon(
    //         !this.selected ? Icons.add_box_outlined : Icons.check_box_rounded,
    //         color: !this.selected ? CColor.minorTextColor : CColor.mainColor,
    //         size: 22,
    //       )
    //     ],
    //   ),
    // );
  }

  static double get height => sHeight(56);
}
