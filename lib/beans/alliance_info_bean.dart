/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       alliance_info_bean
 * @Create:         2020/10/15 7:06 PM
 * @Description:    
 * @author          dt
*/
import 'package:json_annotation/json_annotation.dart';

part 'alliance_info_bean.g.dart';


@JsonSerializable()
class AllianceInfoBean extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'token_id')
  String tokenId;

  @JsonKey(name: 'flag_pic')
  String flagPic;

  @JsonKey(name: 'bio')
  String bio;

  @JsonKey(name: 'author_name')
  String authorName;

  @JsonKey(name: 'prestige')
  int prestige;

  @JsonKey(name: 'money')
  String money;

  AllianceInfoBean(this.id,this.name,this.tokenId,this.flagPic,this.bio,this.authorName,this.prestige,this.money,);

  factory AllianceInfoBean.fromJson(Map<String, dynamic> srcJson) => _$AllianceInfoBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AllianceInfoBeanToJson(this);

}


