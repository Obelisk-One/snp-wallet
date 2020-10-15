/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       snp_list_view
 * @Create:         2020/8/27 5:55 PM
 * @Description:    公用列表组件
 * @author          dt
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/widgets/store/list_view.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/widgets/empty_list_view.dart';

class SListView extends StatefulWidget {
//  final bool isGridView;
  final Function(int index, dynamic item) itemView;
  final EdgeInsets padding;
  final bool firstRefresh;
  final bool separated;
  final SListViewController controller;

  final String apiPath;
  final String method;
  final Map<String, dynamic> params;

  const SListView({
    Key key,
    @required this.apiPath,
    @required this.itemView,
    this.firstRefresh = true,
    this.padding = EdgeInsets.zero,
    this.params,
    this.method = 'GET',
    this.separated = false,
    this.controller,
  }) : super(key: key);

  @override
  _SListViewState createState() => _SListViewState();
}

class _SListViewState extends BaseState<SListView>
    with AutomaticKeepAliveClientMixin {
  final ListViewStore _store = ListViewStore();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: widget.padding,
      child: Observer(
        builder: (_) => EasyRefresh.custom(
          controller: _store.controller,
          firstRefresh: widget.firstRefresh,
          firstRefreshWidget: _firstRefreshWidget(),
          // shrinkWrap: true,
          header: BallPulseHeader(
            color: CColor.mainColor,
          ),
          footer: BallPulseFooter(
            color: CColor.mainColor,
            overScroll: true,
//            enableInfiniteLoad: false,
          ),
          emptyWidget: _store.refreshError
              ? EmptyListView(
                  type: 0,
                  msg: _store.errorData.msg,
                  onRefresh: () async => await _store.refresh(),
                )
              : (_store.dataList.length <= 0
                  ? EmptyListView(
                      onRefresh: () async => await _store.refresh(),
                    )
                  : null),
          slivers: <Widget>[
            SliverList(
              delegate: widget.separated && _store.count > 1
                  ? SliverChildBuilderDelegate(
                      (context, index) => (index + 1) % 2 == 0
                          ? Divider(
                              indent: 10,
                              endIndent: 10,
                            )
                          : _item(index ~/ 2),
                      childCount: _store.count * 2 - 1,
                    )
                  : SliverChildBuilderDelegate(
                      (context, index) => _item(index),
                      childCount: _store.count,
                    ),
            ),
          ],
          onRefresh: () async => await _store.refresh(),
          onLoad: () async => await _store.loadMore(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _store
      ..setApiPath(widget.apiPath ?? '')
      ..setParams(widget.params ?? Map())
      ..setMethod(widget.method)
      ..setController(EasyRefreshController());
    _bindController();
  }

  @override
  void didUpdateWidget(covariant SListView oldWidget) {
    if (oldWidget.controller != widget.controller) {
      _bindController();
    }
    if (widget.params != _store.params) {
      _store.setParams(widget.params);
      _store.refresh();
    }
    super.didUpdateWidget(oldWidget);
  }

  // 绑定Controller
  _bindController() {
    // 绑定控制器
    if (widget.controller != null) widget.controller._bindSListViewState(this);
  }

  _firstRefreshWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(),
            flex: 1,
          ),
          Center(
            child: SpinKitDoubleBounce(
              color: CColor.mainColor,
              size: 35,
            ),
          ),
          Expanded(
            child: SizedBox(),
            flex: 3,
          ),
        ],
      );

  _item(index) {
    if (_store.noMore && index >= _store.count - 1)
      return Container(
        width: screenWidth,
        height: sHeight(40),
        child: Center(
          child: Text(
            '-----我是有底线的-----',
            style: Font.hintS,
          ),
        ),
      );
    else if (_store.loadMoreError && index >= _store.count - 1)
      return Container(
        width: screenWidth,
        height: sHeight(40),
        child: Center(
          child: Text(
            '-----啊哦,出错了-----',
            style: Font.hintS,
          ),
        ),
      );
    else
      return widget.itemView(
        index,
        _store.dataList[index],
      );
  }

  callRefresh() {
    _store.refresh();
  }

  updateParams(Map params) {
    if (params != null) _store.setParams(params);
  }

  @override
  void dispose() {
    _store.clearController();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class SListViewController {
  /// 触发刷新
  callRefresh() {
    if (this._state != null) {
      this._state.callRefresh();
    }
  }

  updateParams(Map params) {
    if (this._state != null) {
      this._state.updateParams(params);
      this._state.callRefresh();
    }
  }

  // 状态
  _SListViewState _state;

  // 绑定状态
  void _bindSListViewState(_SListViewState state) {
    this._state = state;
  }

  void dispose() {
    this._state = null;
  }
}
