/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       list_data_bean
 * @Create:         2020/8/28 10:26 AM
 * @Description:    
 * @author          dt
*/

import 'package:json_annotation/json_annotation.dart';

part 'list_data_bean.g.dart';

@JsonSerializable()
class ListData extends Object {
  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'per_page')
  int perPage;

  @JsonKey(name: 'current_page')
  int currentPage;

  @JsonKey(name: 'last_page')
  int lastPage;

  @JsonKey(name: 'data')
  List<dynamic> data;

  ListData(
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.data,
  );

  factory ListData.fromJson(Map<String, dynamic> srcJson) =>
      _$ListDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ListDataToJson(this);
}
