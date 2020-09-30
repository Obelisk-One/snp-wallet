// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alliance_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllianceBean _$AllianceBeanFromJson(Map<String, dynamic> json) {
  return AllianceBean(
    json['id'] as int,
    json['flag_pic'] as String,
    json['count'] as int,
    json['name'] as String,
    json['exist'] == 1,
  );
}

Map<String, dynamic> _$AllianceBeanToJson(AllianceBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flag_pic': instance.flagPic,
      'count': instance.count,
      'name': instance.name,
      'exist': instance.exist ? 1 : 0,
    };
