/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       circle_loader_view
 * @Create:         2020/8/31 11:25 AM
 * @Description:    
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:snp/common/base/base_color.dart';

class CircleLoader extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;

  const CircleLoader(this.linkNotifier, {Key key}) : super(key: key);

  @override
  CircleLoaderState createState() => new CircleLoaderState();
}

class CircleLoaderState extends State<CircleLoader> {
  // 指示器值
  double _indicatorValue = 0.0;

  RefreshMode get _refreshState => widget.linkNotifier.refreshState;

  double get _pulledExtent => widget.linkNotifier.pulledExtent;

  @override
  void initState() {
    super.initState();
    widget.linkNotifier.addListener(onLinkNotify);
  }

  void onLinkNotify() {
    if (!mounted) return;
    setState(() {
      if (_refreshState == RefreshMode.armed ||
          _refreshState == RefreshMode.refresh) {
        _indicatorValue = null;
      } else if (_refreshState == RefreshMode.refreshed ||
          _refreshState == RefreshMode.done) {
        _indicatorValue = 1.0;
      } else {
        if (_refreshState == RefreshMode.inactive) {
          _indicatorValue = 0.0;
        } else {
          double indicatorValue = _pulledExtent / 70.0 * 0.8;
          _indicatorValue = indicatorValue < 0.8 ? indicatorValue : 0.8;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: 10.0,
        ),
        width: 24.0,
        height: 24.0,
        child: CircularProgressIndicator(
          value: _indicatorValue,
          valueColor: AlwaysStoppedAnimation(CColor.bgColor),
          strokeWidth: 2.4,
        ),
      ),
    );
  }
}
