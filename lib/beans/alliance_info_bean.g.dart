// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alliance_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllianceInfoBean _$AllianceInfoBeanFromJson(Map<String, dynamic> json) {
  return AllianceInfoBean(
    json['id'] as int,
    json['name'] as String,
    json['token_id'] as String,
    json['flag_pic'] as String,
    json['bio'] as String,
    json['author_name'] as String,
    json['prestige'] as int,
    json['money'] as String,
  );
}

Map<String, dynamic> _$AllianceInfoBeanToJson(AllianceInfoBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'token_id': instance.tokenId,
      'flag_pic': instance.flagPic,
      'bio': instance.bio,
      'author_name': instance.authorName,
      'prestige': instance.prestige,
      'money': instance.money,
    };
