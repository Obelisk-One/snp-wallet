// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alliance_apply_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllianceApplyBean _$AllianceApplyBeanFromJson(Map<String, dynamic> json) {
  return AllianceApplyBean(
    json['id'] as int,
    json['message'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['prestige'] as int,
    json['total_prestige'] as int,
    json['state'] as int,
    json['username'] as String,
    json['nickname'] as String,
    json['avatar'] as String,
    json['extend'] == null
        ? null
        : Extend.fromJson(json['extend'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AllianceApplyBeanToJson(AllianceApplyBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'images': instance.images,
      'prestige': instance.prestige,
      'total_prestige': instance.totalPrestige,
      'state': instance.state,
      'username': instance.username,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'extend': instance.extend,
    };

Extend _$ExtendFromJson(Map<String, dynamic> json) {
  return Extend(
    json['invite'] == null
        ? null
        : Invite.fromJson(json['invite'] as Map<String, dynamic>),
    json['league'] == null
        ? null
        : League.fromJson(json['league'] as Map<String, dynamic>),
    json['type'] as String,
  );
}

Map<String, dynamic> _$ExtendToJson(Extend instance) => <String, dynamic>{
      'invite': instance.invite,
      'league': instance.league,
      'type': instance.type,
    };

Invite _$InviteFromJson(Map<String, dynamic> json) {
  return Invite(
    json['message'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['username'] as String,
    json['nickname'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$InviteToJson(Invite instance) => <String, dynamic>{
      'message': instance.message,
      'images': instance.images,
      'username': instance.username,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
    };

League _$LeagueFromJson(Map<String, dynamic> json) {
  return League(
    json['league_id'] as int,
    json['prestige'] as int,
    json['name'] as String,
    json['flag_pic'] as String,
  );
}

Map<String, dynamic> _$LeagueToJson(League instance) => <String, dynamic>{
      'league_id': instance.leagueId,
      'prestige': instance.prestige,
      'name': instance.name,
      'flag_pic': instance.flagPic,
    };
