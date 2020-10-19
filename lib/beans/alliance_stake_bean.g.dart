// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alliance_stake_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllianceStakeBean _$AllianceStakeBeanFromJson(Map<String, dynamic> json) {
  return AllianceStakeBean(
    json['user_id'] as int,
    json['username'] as String,
    json['nickname'] as String,
    json['avatar'] as String,
    json['stake_total'] as int,
    json['stake_num'] as int,
  );
}

Map<String, dynamic> _$AllianceStakeBeanToJson(AllianceStakeBean instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'stake_total': instance.stakeTotal,
      'stake_num': instance.stakeNum,
    };
