/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       tab_view
 * @Create:         2020/9/1 2:15 PM
 * @Description:    
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';

class TabView extends StatefulWidget {
  final List<dynamic> tabs;
  final List<Widget> views;
  final Color indicatorColor;
  final Color labelColor;
  final TextStyle labelStyle;
  final Color unselectedLabelColor;
  final TextStyle unselectedLabelStyle;
  final bool tabsAlignLeft;
  final double height;
  final int initialIndex;
  final bool bouncing;
  final EdgeInsetsGeometry tabMargin;
  final Function onChanged;

  /// tabs:tab标题数组(可以为字符串或Tab组件)
  /// views:页面数组(必须与tabs的长度相同)
  /// indicatorColor:tab指示器的颜色
  /// labelColor:选中的字体颜色
  /// labelStyle:选中的TextStyle
  /// unselectedLabelColor:未选中的字体颜色
  /// unselectedLabelStyle:未选中的TextStyle
  /// tabsAlignLeft:tab是否左对齐
  /// height:view的高度(当TabView放在滚动组件内的时候,需要明确高度,否则会报错)
  /// initialIndex:初始页面下标
  /// bouncing:是否有回弹效果
  TabView({
    Key key,
    @required this.tabs,
    @required this.views,
    this.indicatorColor = CColor.mainColor,
    this.labelColor = CColor.lightTextColor,
    this.labelStyle,
    this.unselectedLabelColor = CColor.minorTextColor,
    this.unselectedLabelStyle,
    this.tabsAlignLeft = false,
    this.height,
    this.initialIndex = 0,
    this.bouncing = true,
    this.tabMargin,
    this.onChanged,
  })  : assert(tabs != null && tabs.length >= 0),
        assert(views != null && views.length >= 0),
        assert(tabs.length == views.length),
        assert(tabs.length > initialIndex),
        super(key: key);

  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView>
    with SingleTickerProviderStateMixin {
  GlobalKey _key = GlobalKey();
  TabController _tabController;
  double _height;

  @override
  Widget build(BuildContext context) {
    final _tabView = TabBarView(
      controller: _tabController,
      key: _key,
      physics:
          widget.bouncing ? BouncingScrollPhysics() : ClampingScrollPhysics(),
      children: widget.views,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment:
              widget.tabsAlignLeft ? Alignment.topLeft : Alignment.center,
          margin: widget.tabMargin ?? sInsetsHV(10, 0),
          child: TabBar(
            controller: _tabController,
            indicatorColor: CColor.mainColor,
            labelColor: CColor.lightTextColor,
            labelStyle: widget.labelStyle ?? Font.lightL,
            unselectedLabelColor: CColor.minorTextColor,
            unselectedLabelStyle: widget.unselectedLabelStyle ?? Font.minorL,
            isScrollable: widget.tabsAlignLeft,
            tabs: widget.tabs.map((e) {
              if (e is String)
                return Tab(text: e);
              else if (e is Widget)
                return e;
              else
                return Tab();
            }).toList(),
          ),
        ),
        widget.height == null
            ? Flexible(child: _tabView)
            : Container(
                height: widget.height,
                child: _tabView,
              ),
      ],
    );
  }

  // @override
  // void didChangeDependencies() {
  //   WidgetsBinding.instance.addPostFrameCallback(_getHeight);
  //   super.didChangeDependencies();
  // }
  //
  // @override
  // void didUpdateWidget(TabView oldWidget) {
  //   WidgetsBinding.instance.addPostFrameCallback(_getHeight);
  //   super.didUpdateWidget(oldWidget);
  // }
  //
  // _getHeight(_) {
  //   // print(_key.currentContext.size.height);
  //   // sState(() => _height = _key.currentContext.size.height);
  //   RenderBox _renderBox = _key.currentContext.findRenderObject();
  //   Offset _offset = _renderBox.localToGlobal(Offset.zero);
  //   print('=====================' + _renderBox.size.height.toString());
  // }

  @override
  void initState() {
    super.initState();
    _height = widget.height ?? double.infinity;
    _tabController = TabController(
      vsync: this,
      length: widget.tabs.length,
      initialIndex: widget.initialIndex,
    )..addListener(() {
        if (_tabController.index.toDouble() == _tabController.animation.value &&
            widget.onChanged != null) widget.onChanged(_tabController.index);
      });
  }
}
