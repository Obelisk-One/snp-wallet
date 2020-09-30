/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       alliance_bean
 * @Create:         2020/9/21 6:28 PM
 * @Description:    
 * @author          dt
*/
import 'package:json_annotation/json_annotation.dart';

part 'alliance_bean.g.dart';

List<AllianceBean> getAllianceBeanList(List<dynamic> list) {
  List<AllianceBean> result = [];
  list.forEach((item) {
    result.add(AllianceBean.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class AllianceBean extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'flag_pic')
  String flagPic;

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'exist')
  bool exist;

  AllianceBean(
    this.id,
    this.flagPic,
    this.count,
    this.name,
    this.exist,
  );

  factory AllianceBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AllianceBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AllianceBeanToJson(this);
}
