/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       user_bean
 * @Create:         2020/9/15 3:47 PM
 * @Description:    
 * @author          dt
*/
import 'package:json_annotation/json_annotation.dart';

part 'user_bean.g.dart';

@JsonSerializable()
class UserBean extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'bio')
  String disc;

  @JsonKey(name: 'area_name')
  String areaName;

  @JsonKey(name: 'area_code')
  String areaCode;

  UserBean(
    this.id,
    this.username,
    this.nickname,
    this.avatar,
    this.gender,
    this.disc,
    this.areaName,
    this.areaCode,
  );

  factory UserBean.fromJson(Map<String, dynamic> srcJson) =>
      _$UserBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserBeanToJson(this);
}
