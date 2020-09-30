/*
 * @Project:        snp
 * @Package:        common.utils
 * @FileName:       upload_util
 * @Create:         2020/9/22 5:28 PM
 * @Description:    
 * @author          dt
*/

import 'dart:math';

import 'package:aliossflutter/aliossflutter.dart';
import 'package:flutter/foundation.dart';
import 'package:snp/common/base/base_config.dart';
import 'package:snp/common/utils/ui_util.dart';

OSSUtil oss = OSSUtil();

typedef OnUploadFinish = void Function(
  bool success,
  String key,
  String msg,
);

typedef OnDeleteFinish = void Function(
  bool success,
  String key,
);

typedef OnProgress = void Function(int data);

class OSSUtil {
  // 单例公开访问点
  factory OSSUtil() => _sharedInstance();

  // 静态私有成员
//  static Loading _instance;//懒汉模式(加载时速度较快，运行时获取实例速度较慢)
  static OSSUtil _instance = OSSUtil._(); //饿汉模式(加载时获取实例速度较慢，运行时速度较快)
  var _uploadFinish, _deleteFinish;
  bool _toast = true;

  // 私有构造函数
  OSSUtil._() {
    if (_oss == null) {
      _oss = AliOSSFlutter();
      _oss.init(
        Config.oss_sts_server,
        Config.oss_endpoint,
        cryptkey: Config.oss_crypt_key,
      );
      _oss.responseFromInit.listen((result) {
        if (!result) {
          if (_toast) toast('获取OSSToken失败');
          if (_uploadFinish != null) _uploadFinish(false, '', '获取OSSToken失败');
          if (_deleteFinish != null) _deleteFinish(false, '');
          // _onFinish = null;
        }
      });
      _oss.responseFromProgress.listen((data) {
        debugPrint(
            'upload (${data.key}) progress:${data.currentSize}/${data.totalSize}');
      });
      _oss.responseFromUpload.listen((data) {
        if (!data.success && _toast) toast('图片上传失败\n${data.msg}');
        if (_uploadFinish != null) {
          _uploadFinish(data.success, data.key, data.msg);
          // _onFinish = null;
        }
      });
      _oss.responseFromDelete.listen((data) {
        print('delete (${data.key}) ${data.success ? 'success' : 'failed'}');
        if (_deleteFinish != null) {
          _deleteFinish(data.success, data.key);
          // _onFinish = null;
        }
      });
    }
  }

  // 静态、同步、私有访问点
  static OSSUtil _sharedInstance() {
    return _instance;
  }

  AliOSSFlutter _oss;

  uploadImage(
    String localFilePath,
    String remotePath, {
    bool toast = true,
    OnUploadFinish onFinish,
    OnProgress onProcess,
  }) {
    _uploadFinish = onFinish;
    _toast = toast;
    var fileKey = '${remotePath ?? ''}$randomFilename';
    _oss.upload(
      Config.oss_bucket,
      localFilePath,
      fileKey,
//      callbackBody: Config.callbackBody,
//      callbackBodyType: Config.callbackBodyType,
//      callbackHost: Config.callbackHost,
//      callbackUrl: Config.callbackUrl,
//      callbackVars: Config.callbackVars,
    );
  }

  deleteImage(
    String key, {
    OnDeleteFinish onFinish,
  }) async {
    _deleteFinish = onFinish;
    if (await isExist(key)) {
      _oss.delete(Config.oss_bucket, key);
    }
  }

  isExist(String key) async {
    return await _oss
        .exist(Config.oss_bucket, key)
        .catchError((err) => toast(err));
  }

  String get randomFilename {
    DateTime date = DateTime.now();
    return '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}${date.hour.toString().padLeft(2, '0')}${date.minute.toString().padLeft(2, '0')}${date.second.toString().padLeft(2, '0')}_${_randomString(4)}.jpg';
  }

  String _randomString(int size) {
    String allChars =
        "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String result = "";
    for (int i = 0; i < size; i++) {
      int index = Random().nextInt(999999) % (allChars.length - 1);
      result += allChars[index];
    }
    return result;
  }
}
