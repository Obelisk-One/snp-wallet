/*
 * @Project:        snp
 * @Package:        store
 * @FileName:       user
 * @Create:         2020/9/10 3:44 PM
 * @Description:    
 * @author          dt
*/

//1. 执行命令: flutter packages pub run build_runner build
//2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
//3. 实时更新.g文件: flutter packages pub run build_runner watch

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:snp/beans/user_bean.dart';
import 'package:snp/common/utils/http_util.dart';
import 'package:snp/common/utils/ui_util.dart';
import 'package:snp/common/utils/user_util.dart';
import 'package:snp/main.dart';

part 'user.g.dart';

class UserStore = UserMobx with _$UserStore;

//全局Store对象,所有页面共用,需要的话取消注释
//final UserStore user = UserStore();

abstract class UserMobx with Store {
  @observable
  bool isLogin = false;
  @observable
  String password = '';
  @observable
  UserBean bean;

  // @computed
  // UserBean get bean => userBean;

  @action
  doRegister(
    String username,
    String nickname,
  ) async {
    this.password = '';
    showLoading();
    await user.doRegister(
      username: username,
      nickname: nickname,
      onSuccess: (data) {
        dismissLoading();
        this.isLogin = user.isLogin;
        this.password = data.data['words'];
        toast('设备注册成功,请记录助记词');
      },
      onError: (error) {
        dismissLoading();
        this.password = '';
        toast(error.msg);
      },
    );
  }

  @action
  verifyWithWords({
    @required String words,
    SuccessCallBack onSuccess,
    ErrorCallBack onError,
  }) async =>
      user
          .verifyWithWords(
        words: words,
        onSuccess: onSuccess,
        onError: onError,
      )
          .then((data) {
        this.isLogin = user.isLogin;
        if (!data.error) fetchUserInfo();
        return data;
      });

  @action
  fetchUserInfo() async => user.fetchUserInfo().then((data) {
        if (data.error)
          toast('获取用户信息失败');
        else
          this.bean = UserBean.fromJson(data.data);
      });

  setInfo(String key, value) async => user
      .setInfo(
        key,
        value,
        onSuccess: (data) => fetchUserInfo(),
        // onError: (error) => toast('设置失败'),
      )
      .then((data) => !data.error);

  setUsername(value) async => setInfo('username', value);

  setNickname(value) async => setInfo('nickname', value);

  setAvatar(value) async => setInfo('avatar', value);

  setGender(value) async => setInfo('gender', value);

  setArea(value) async => setInfo('area', value);

  setDescription(value) async => setInfo('bio', value);
}

UserStore globalUserStore() {
  return Provider.of<UserStore>(rootKey.currentContext, listen: false);
}