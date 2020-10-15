// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_alliance_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAllianceBean _$MyAllianceBeanFromJson(Map<String, dynamic> json) {
  return MyAllianceBean(
    json['league_id'] as int,
    json['prestige'] as int,
    json['name'] as String,
    json['flag_pic'] as String,
    (json['medal'] as List)
        ?.map(
            (e) => e == null ? null : Medal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyAllianceBeanToJson(MyAllianceBean instance) =>
    <String, dynamic>{
      'league_id': instance.leagueId,
      'prestige': instance.prestige,
      'name': instance.name,
      'flag_pic': instance.flagPic,
      'medal': instance.medal,
    };

Medal _$MedalFromJson(Map<String, dynamic> json) {
  return Medal(
    json['name'] as String,
    json['image'] as String,
  );
}

Map<String, dynamic> _$MedalToJson(Medal instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
    };
