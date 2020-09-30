/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       web_image_view
 * @Create:         2020/9/24 5:50 PM
 * @Description:    
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';

class WebImage extends StatelessWidget {
  final String url, styleName;
  final EdgeInsetsGeometry margin;
  final double height, width;
  final BoxFit fit;

  const WebImage({
    Key key,
    @required this.url,
    this.styleName,
    this.margin,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}
