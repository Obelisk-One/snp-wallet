// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBean _$UserBeanFromJson(Map<String, dynamic> json) {
  return UserBean(
    json['id'] as int,
    json['username'] as String,
    json['nickname'] as String,
    json['avatar'] as String,
    json['gender'] as int,
    json['bio'] as String,
    json['area_name'] as String,
    json['area_code'] as String,
  );
}

Map<String, dynamic> _$UserBeanToJson(UserBean instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'gender': instance.gender,
      'bio': instance.disc,
      'area_name': instance.areaName,
      'area_code': instance.areaCode,
    };
