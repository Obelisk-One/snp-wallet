/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       content_cell_view
 * @Create:         2020/10/20 3:50 PM
 * @Description:    
 * @author          dt
*/
import 'package:flutter/material.dart';
import 'package:image_selector/image_selector.dart';
import 'package:snp/beans/content_bean.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/base/base_stateful.dart';
import 'package:snp/ui/pages/news/post_content_view.dart';
import 'package:snp/ui/widgets/avatar_view.dart';
import 'package:snp/ui/widgets/web_image_view.dart';

typedef void ContentClickedCallback(int id);

class ContentCell extends StatefulWidget {
  final ContentBean bean;
  final EdgeInsetsGeometry margin;
  final bool canReply, showLine, showFull;
  final ContentClickedCallback onClick;
  final bool isLast, isFirst, showBottomLine;

  const ContentCell({
    Key key,
    @required this.bean,
    this.margin,
    this.canReply = true,
    this.showLine = false,
    this.showFull = false,
    this.onClick,
    this.isLast = false,
    this.isFirst = false,
    this.showBottomLine = false,
  })  : assert(bean != null),
        super(key: key);

  @override
  _ContentCellState createState() => _ContentCellState();
}

class _ContentCellState extends BaseState<ContentCell> {
  int _replyCount = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          widget.onClick != null ? () => widget.onClick(widget.bean.id) : null,
      child: Container(
        margin: widget.margin ?? sInsetsAll(0),
        padding: sInsetsHV(10, 0),
        color: CColor.bgColor,
        child: Stack(
          children: [
            Positioned.fill(
              top: widget.isFirst ? sHeight(15) : 0,
              left: sWidth(19),
              child: Container(
                color: CColor.lineColor,
              ),
            ),
            Positioned.fill(
              top: sHeight(15),
              left: sWidth(19),
              child: Visibility(
                visible: widget.isLast,
                child: Container(
                  color: CColor.bgColor,
                ),
              ),
            ),
            Positioned.fill(
              top: 0,
              left: sWidth(widget.showLine ? 22 : 0),
              child: Container(
                color: CColor.bgColor,
              ),
            ),
            widget.isLast
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gap(height: 10),
                      Row(
                        children: [
                          Avatar(
                            widget.bean.avatar,
                            size: 40,
                          ),
                          gap(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.bean.nickname}',
                                  style: Font.normal,
                                ),
                                gap(height: 5),
                                Text(
                                  '${widget.bean.username.isEmpty ? '' : '@${widget.bean.username}'}',
                                  style: Font.minorS,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            TimelineUtil.format(
                              widget.bean.createtime * 1000,
                              locale: 'zh',
                            ),
                            style: Font.minorXS,
                          ),
                        ],
                      ),
                      gap(height: 10),
                      _contentView,
                      gap(height: 10),
                      _lastStyleImageView,
                      gap(height: 10),
                      _bottomView,
                      gap(height: 10),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: sInsetsLTRB(0, 10, 5, 0),
                        child: Avatar(
                          widget.bean.avatar,
                          size: 40,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            gap(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: '${widget.bean.nickname} ',
                                        style: Font.normal,
                                      ),
                                      TextSpan(
                                        text:
                                            '${widget.bean.username.isEmpty ? '' : '@${widget.bean.username}'}',
                                        style: Font.minorS,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  TimelineUtil.format(
                                    widget.bean.createtime * 1000,
                                    locale: 'zh',
                                  ),
                                  style: Font.minorXS,
                                ),
                              ],
                            ),
                            gap(height: 5),
                            _contentView,
                            gap(height: 5),
                            _imageView,
                            gap(height: 10),
                            _bottomView,
                            gap(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: widget.showBottomLine ? Divider() : gap(),
            ),
          ],
        ),
      ),
    );
  }

  get _contentView => Text(
        widget.bean.message,
        style: widget.isLast ? Font.normalH : Font.normal,
        maxLines: widget.showFull ? 99 : 3,
        overflow: TextOverflow.ellipsis,
      );

  get _imageView => Row(
        children: widget.bean.images.map(
          (e) {
            int _index = widget.bean.images.indexOf(e);
            return GestureDetector(
              onTap: () => ImageSelector.previewWebImages(
                _index,
                widget.bean.images,
              ),
              child: WebImage(
                url: e,
                radius: 5,
                width: imageSize,
                height: imageSize,
                style: Config.oss_style_thumb,
                margin: sInsetsLTRB(_index == 0 ? 0 : 5, 0, 0, 0),
              ),
            );
          },
        ).toList(),
      );

  get _lastStyleImageView {
    int _length = widget.bean.images.length;
    switch (_length) {
      case 1:
        String _url = widget.bean.images[0];
        double _width = screenWidth - sWidth(20);
        double _height = _width / 1.618;
        return GestureDetector(
          onTap: () => ImageSelector.previewWebImages(0, widget.bean.images),
          child: WebImage(
            url: _url,
            radius: 5,
            width: _width,
            height: _height,
            style: Config.oss_style_org,
          ),
        );
        break;
      case 2:
      case 3:
        double _imageGap = 5;
        double _imageSize =
            (screenWidth - sWidth(20 + _imageGap * (_length - 1))) / _length;
        return Row(
          children: widget.bean.images.map(
            (e) {
              int _index = widget.bean.images.indexOf(e);
              return GestureDetector(
                onTap: () => ImageSelector.previewWebImages(
                  _index,
                  widget.bean.images,
                ),
                child: WebImage(
                  url: e,
                  radius: 5,
                  width: _imageSize,
                  height: _imageSize,
                  style: Config.oss_style_thumb,
                  margin: sInsetsLTRB(_index == 0 ? 0 : _imageGap, 0, 0, 0),
                ),
              );
            },
          ).toList(),
        );
        break;
      default:
        return gap();
    }
  }

  get _bottomView => GestureDetector(
        onTap: widget.canReply
            ? () => RouteUtil.showModelPage(
                  PostContentPage(replyBean: widget.bean),
                  (data) {
                    if (data != null &&
                        data is ContentBean &&
                        data.id == widget.bean.id) sState(() => _replyCount++);
                  },
                )
            : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              SnpIcon.reply,
              size: 16,
              color: CColor.iconColor,
            ),
            Text(
              '  $_replyCount  ',
              style: Font.minor,
            ),
          ],
        ),
      );

  @override
  void initState() {
    _replyCount = widget.bean.comments;
    super.initState();
  }

  double get imageSize => (screenWidth - sWidth(65)) / 3;
}
