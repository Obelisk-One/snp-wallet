/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       my_alliance_bean
 * @Create:         2020/10/15 2:48 PM
 * @Description:    
 * @author          dt
*/
import 'package:json_annotation/json_annotation.dart';

part 'my_alliance_bean.g.dart';


List<MyAllianceBean> getMyAllianceBeanList(List<dynamic> list){
  List<MyAllianceBean> result = [];
  list.forEach((item){
    result.add(MyAllianceBean.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class MyAllianceBean extends Object {

  @JsonKey(name: 'league_id')
  int leagueId;

  @JsonKey(name: 'prestige')
  int prestige;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'flag_pic')
  String flagPic;

  @JsonKey(name: 'medal')
  List<Medal> medal;

  MyAllianceBean(this.leagueId,this.prestige,this.name,this.flagPic,this.medal,);

  factory MyAllianceBean.fromJson(Map<String, dynamic> srcJson) => _$MyAllianceBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MyAllianceBeanToJson(this);

}


@JsonSerializable()
class Medal extends Object {

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'image')
  String image;

  Medal(this.name,this.image,);

  factory Medal.fromJson(Map<String, dynamic> srcJson) => _$MedalFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MedalToJson(this);

}


