/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       alliance_stake_bean
 * @Create:         2020/10/16 3:35 PM
 * @Description:    
 * @author          dt
*/
import 'package:json_annotation/json_annotation.dart';

part 'alliance_stake_bean.g.dart';

List<AllianceStakeBean> getAllianceStakeBeanList(List<dynamic> list) {
  List<AllianceStakeBean> result = [];
  list.forEach((item) {
    result.add(AllianceStakeBean.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class AllianceStakeBean extends Object {
  @JsonKey(name: 'user_id')
  int userId;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'stake_total')
  int stakeTotal;

  @JsonKey(name: 'stake_num')
  int stakeNum;

  AllianceStakeBean(
    this.userId,
    this.username,
    this.nickname,
    this.avatar,
    this.stakeTotal,
    this.stakeNum,
  );

  factory AllianceStakeBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AllianceStakeBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AllianceStakeBeanToJson(this);
}
