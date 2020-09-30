/*
 * @Project:        snp
 * @Package:        common.utils
 * @FileName:       user_util
 * @Create:         2020/9/10 11:11 AM
 * @Description:    
 * @author          dt
*/
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:snp/common/common.dart';
import 'package:uuid/uuid.dart';

UserUtil user = UserUtil();

class UserUtil {
  // 单例公开访问点
  factory UserUtil() => _sharedInstance();

  // 静态私有成员
//  static Loading _instance;//懒汉模式(加载时速度较快，运行时获取实例速度较慢)
  static UserUtil _instance = UserUtil._(); //饿汉模式(加载时获取实例速度较慢，运行时速度较快)

  // 私有构造函数
  UserUtil._() {
    // 具体初始化代码
  }

  // 静态、同步、私有访问点
  static UserUtil _sharedInstance() {
    return _instance;
  }

  /// 是否已登录
  bool get isLogin =>
      clientId.isNotEmpty && token.isNotEmpty && privateKey.isNotEmpty;

  String _clientId = SpUtil.getString(Config.sp_key_client_id);

  String get clientId {
    if (_clientId.isEmpty) {
      _clientId = SpUtil.getString(Config.sp_key_client_id);
    }
    return _clientId;
  }

  // Future<String> _getClientId() async {
  //   String result = SpUtil.getString(Config.sp_key_client_id);
  //   if (ObjectUtil.isEmptyString(result)) {
  //     String plant = Uuid().v4() + DateTime.now().millisecond.toString();
  //     result = await Future.sync(() => EncryptUtil.encodeMd5(plant));
  //     SpUtil.putString(Config.sp_key_client_id, result);
  //   }
  //   // _clientId = result;
  //   return result;
  // }

  String _token = '';

  String get token {
    if (_token.isEmpty) {
      _token = SpUtil.getString(Config.sp_key_token);
    }
    return _token;
  }

  set token(String token) {
    _token = token;
    SpUtil.putString(Config.sp_key_token, token);
  }

  String _privateKey = '';

  String get privateKey {
    if (_privateKey.isEmpty) {
      _privateKey = SpUtil.getString(Config.sp_key_private_key);
    }
    return _privateKey;
  }

  set privateKey(String privateKey) {
    _privateKey = privateKey;
    SpUtil.putString(Config.sp_key_private_key, privateKey);
  }

  doRegister({
    @required String username,
    @required String nickname,
    SuccessCallBack onSuccess,
    ErrorCallBack onError,
  }) async {
    // SpUtil.putString(Config.sp_key_client_id, '');
    await http.post(
      API.register,
      params: {
        'client_id': clientId,
        'user_name': username,
        'nick_name': nickname,
      },
      onSuccess: (data) {
        if (ObjectUtil.isNotEmpty(data.data)) {
          user.token = data.data['token'];
          user.privateKey = data.data['private_key'];
        }
        if (onSuccess != null) onSuccess(data);
      },
      onError: onError,
    );
  }

  verifyWithWords({
    @required String words,
    SuccessCallBack onSuccess,
    ErrorCallBack onError,
  }) async =>
      http.post(
        API.verifyUser,
        params: {
          'client_id': clientId,
          'import_type': 'words',
          'value': words,
        },
        onSuccess: (data) {
          user.token = data.data['token'];
          user.privateKey = data.data['private_key'];
          if (onSuccess != null) onSuccess(data);
        },
        onError: onError,
      );

  Future<ResultData> fetchUserInfo() async => await http.get(API.userInfo);

  Future<ResultData> setInfo(
    String key,
    value, {
    SuccessCallBack onSuccess,
    ErrorCallBack onError,
  }) async =>
      await HttpUtil.getInstance().post(
        API.updateUserInfo,
        params: {
          'field': key,
          'value': value,
        },
        onSuccess: onSuccess,
        onError: onError,
      );
}
