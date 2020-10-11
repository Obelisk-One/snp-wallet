/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       alliance_apply_bean
 * @Create:         2020/10/11 9:53 AM
 * @Description:    
 * @author          dt
*/
import 'package:json_annotation/json_annotation.dart';

part 'alliance_apply_bean.g.dart';

List<AllianceApplyBean> getAllianceApplyBeanList(List<dynamic> list) {
  List<AllianceApplyBean> result = [];
  list.forEach((item) {
    result.add(AllianceApplyBean.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class AllianceApplyBean extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'prestige')
  int prestige;

  @JsonKey(name: 'total_prestige')
  int totalPrestige;

  @JsonKey(name: 'state')
  int state;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'extend')
  Extend extend;

  AllianceApplyBean(
    this.id,
    this.message,
    this.images,
    this.prestige,
    this.totalPrestige,
    this.state,
    this.username,
    this.nickname,
    this.avatar,
    this.extend,
  );

  factory AllianceApplyBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AllianceApplyBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AllianceApplyBeanToJson(this);
}

@JsonSerializable()
class Extend extends Object {
  @JsonKey(name: 'invite')
  Invite invite;

  @JsonKey(name: 'league')
  League league;

  @JsonKey(name: 'type')
  String type;

  Extend(
    this.invite,
    this.league,
    this.type,
  );

  factory Extend.fromJson(Map<String, dynamic> srcJson) =>
      _$ExtendFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExtendToJson(this);
}

@JsonSerializable()
class Invite extends Object {
  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  Invite(
    this.message,
    this.images,
    this.username,
    this.nickname,
    this.avatar,
  );

  factory Invite.fromJson(Map<String, dynamic> srcJson) =>
      _$InviteFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InviteToJson(this);
}

@JsonSerializable()
class League extends Object {
  @JsonKey(name: 'league_id')
  int leagueId;

  @JsonKey(name: 'prestige')
  int prestige;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'flag_pic')
  String flagPic;

  League(
    this.leagueId,
    this.prestige,
    this.name,
    this.flagPic,
  );

  factory League.fromJson(Map<String, dynamic> srcJson) =>
      _$LeagueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LeagueToJson(this);
}
