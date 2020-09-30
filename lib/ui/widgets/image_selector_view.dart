/*
 * @Project:        snp
 * @Package:        ui.widgets
 * @FileName:       image_selector_view
 * @Create:         2020/9/18 4:00 PM
 * @Description:    
 * @author          dt
*/
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_selector/image_selector.dart';
import 'package:snp/common/common.dart';
import 'package:snp/ui/widgets/store/image_selector.dart';
export 'package:snp/ui/widgets/store/image_selector.dart';

// ignore: must_be_immutable
class ImageSelectorView extends StatelessWidget {
  final int maxImage;
  final int countInLine;
  final bool uploadAfterSelect;
  final ImageSelectorStore store;

  ImageSelectorView({
    Key key,
    this.maxImage = 3,
    this.countInLine = 3,
    this.uploadAfterSelect = false,
    @required this.store,
  }) : super(key: key);

  // List _selected = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: sInsetsHV(10, 0),
      width: screenWidth,
      child: Observer(
        builder: (_) => Wrap(
          spacing: 5,
          runSpacing: 5,
          children: _getItems(store.imgList, context),
        ),
      ),
    );
  }

  List<Widget> _getItems(List imgList, BuildContext context) {
    List<Widget> _items = imgList
        .map(
          (item) => _renderImageCell(item),
        )
        .toList();
    if (imgList.length < maxImage) _items.add(_renderAddItem(context));
    return _items;
  }

  Widget _renderImageCell(ImageSelectorItem item) => Stack(
        children: [
          GestureDetector(
            // TODO 查看图片的时候IOS端会出现乱序问题(猜测是原生端拿到List之后顺序乱了)
            onTap: () => ImageSelector.previewImages(
              store.imgList.indexOf(item),
              store.originalDatas,
            ),
            child: Container(
              width: _itemWidth,
              height: _itemWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: item.path.startsWith('http')
                      ? CachedNetworkImage(imageUrl: item.path)
                      : FileImage(File(item.path)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Visibility(
            visible: item.isError,
            child: Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: () => store.retryUpload(item),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CColor.coverColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 25,
                        color: CColor.overMainTextColor,
                      ),
                      Text(
                        '上传失败\n点击重试',
                        style: Font.overMainS,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: ClipOval(
              child: GestureDetector(
                onTap: () => store.deleteImage(item),
                child: Container(
                  color: CColor.coverColor,
                  padding: sInsetsAll(3),
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: CColor.overMainTextColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  _renderAddItem(BuildContext context) => GestureDetector(
        onTap: () => _showImagePicker(context),
        child: Container(
          width: _itemWidth,
          height: _itemWidth,
          decoration: BoxDecoration(
            color: CColor.bgGrayColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              Icons.add,
              size: 30,
              color: CColor.iconColor,
            ),
          ),
        ),
      );

  double get _itemWidth =>
      (screenWidth - (countInLine - 1) * 5 - sWidth(20)) / countInLine;

  _showImagePicker(BuildContext context) {
    RouteUtil.showImagePicker(context).then(
      (value) {
        try {
          bool isCamera = value == 1;
          if (ObjectUtil.isEmpty(value)) return;
          ImageSelector.selectImages(
            maxImage: maxImage,
            camera: isCamera,
            selected: store.originalDatas,
          ).then((value) {
            if (isCamera)
              store.addImage(ImageSelectorItem(
                value.first,
                value.first['id'].toString(),
                value.first['path'],
              ));
            else
              store.marginList(value);
            // if (!isCamera) store.clearImage();
            // value.forEach(
            //   (e) => store.addImage(ImageSelectorItem(e,e['id'],e['path'])),
            // );
          });
        } on PlatformException catch (e) {
          print(e.message);
        }
      },
    );
  }

// _deleteImage(ImageSelectorItem item) {
//   store.deleteImage(item);
// }
}
