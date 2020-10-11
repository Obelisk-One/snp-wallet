/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       web_image_view
 * @Create:         2020/9/24 5:50 PM
 * @Description:    
 * @author          dt
*/

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snp/common/common.dart';

class WebImage extends StatelessWidget {
  final String url, style;
  final EdgeInsetsGeometry margin;
  final double height, width, radius;
  final BoxFit fit;
  final Widget overView;

  const WebImage({
    Key key,
    @required this.url,
    this.style = Config.oss_style_org,
    this.margin,
    this.height = double.infinity,
    this.width = double.infinity,
    this.radius = 0,
    this.fit = BoxFit.cover,
    this.overView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _size = min(sWidth(100), min(width, height)) / 2;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: height,
        maxWidth: width,
      ),
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: url + style,
        imageBuilder: (context, imageProvider) => Container(
          // height: sHeight(90),
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
          child: overView,
        ),
        placeholder: (context, url) => _placeHolderView(
          Stack(
            children: [
              Center(
                child: SpinKitCircle(
                  color: CColor.mainColor,
                  size: _size,
                ),
              ),
              overView,
            ],
          ),
        ),
        errorWidget: (context, url, error) => _placeHolderView(
          Stack(
            children: [
              Center(
                child: Icon(
                  SnpIcon.image_failed,
                  color: CColor.hintTextColor,
                  size: _size,
                ),
              ),
              overView,
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeHolderView(child) => Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: CColor.bgPartColor,
        ),
        child: child,
      );
}
