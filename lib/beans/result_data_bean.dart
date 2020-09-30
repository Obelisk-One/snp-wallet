/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       result_data_bean
 * @Create:         2020/8/28 11:50 AM
 * @Description:    
 * @author          dt
*/
import 'package:json_annotation/json_annotation.dart';

part 'result_data_bean.g.dart';

@JsonSerializable()
class ResultData extends Object {
  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'time')
  int time;

  @JsonKey(name: 'data')
  dynamic data;

  bool error = false;

  ResultData(
    this.code,
    this.msg,
    this.time,
    this.data,
  );

  ResultData.error(
    this.code,
    this.msg, {
    this.time = 0,
    this.data,
    this.error = true,
  });

  factory ResultData.fromJson(Map<String, dynamic> srcJson) =>
      _$ResultDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}
