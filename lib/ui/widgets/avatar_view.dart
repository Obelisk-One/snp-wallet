/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       avatar_view
 * @Create:         2020/9/21 9:57 PM
 * @Description:    
 * @author          dt
*/
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snp/common/common.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double size;

  const Avatar(this.url, {Key key, this.size = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sWidth(size),
      height: sWidth(size),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url ?? Config.defaultAvatar,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: SpinKitDoubleBounce(
              color: CColor.mainColor,
              size: sWidth(30),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: CColor.bgPartColor,
          ),
        ),
      ),
    );
  }
}
