/*
 * 项目名:    snp
 * 包名       base.utils
 * 文件名:    route_util
 * 创建时间:  2020/8/25 on 4:38 PM
 * 描述:     
 *
 * @author   Dino
 */
import 'package:flutter/material.dart';
import 'package:snp/main.dart';

push(Widget widget) => RouteUtil.push(widget, rootKey.currentContext);

pop() => RouteUtil.pop(rootKey.currentContext);

popData(data) => RouteUtil.popWithData(data, rootKey.currentContext);

class RouteUtil {
  static bool canPop(BuildContext context) {
    return Navigator.of(context).canPop();
  }

  static void pushName(String name, BuildContext context) {
    Navigator.of(context).pushNamed(name);
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void maybePop(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  static void popWithData(data, BuildContext context) {
    Navigator.of(context).pop(data);
  }

  static void push(Widget widget, BuildContext context) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (_) {
          return widget;
        },
      ),
    );
  }

  static void scalePush(Widget widget, BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
//      AnimationController controller = animation as AnimationController;
//      controller.duration = Duration(milliseconds: 2000);
          return ScaleTransition(
              scale: animation,
              alignment: Alignment.centerRight,
              child: widget);
        },
      ),
    );
  }

  static Future pushAndReturn(Widget widget, BuildContext context) {
    Future f = Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (_) {
          return widget;
        },
      ),
    );
    return f;
  }

  static void pushAndRemoveUntil(Widget widget, BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => widget),
      (Route<dynamic> route) => false,
    );
  }

  static void pushReplacement(Widget widget, BuildContext context) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(
        builder: (_) {
          return widget;
        },
      ),
    );
  }

  static void pushAndReceive(
      Widget widget, Function receive, BuildContext context) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) {
          return widget;
        },
      ),
    ).then(receive);
  }

  static void popToRoot(BuildContext context) {
//    Navigator.popUntil(
//      context,
//      ModalRoute.withName(Navigator.defaultRouteName),
//    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static void showModelPage(Widget page, [Function receive]) {
    showModalBottomSheet(
      context: rootKey.currentContext,
      elevation: 10,
      useRootNavigator: true,
      // barrierColor: CColor.coverColor,
      isScrollControlled: true,
      enableDrag: false,
      builder: (_) => page,
    ).then(receive ?? (data) {});
  }

  static showImagePicker(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('拍照', textAlign: TextAlign.center),
                onTap: () => popWithData(1, context),
              ),
              Divider(),
              ListTile(
                title: Text('从相册选择', textAlign: TextAlign.center),
                onTap: () => popWithData(2, context),
              ),
              Divider(),
              ListTile(
                title: Text('取消', textAlign: TextAlign.center),
                onTap: () => pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
