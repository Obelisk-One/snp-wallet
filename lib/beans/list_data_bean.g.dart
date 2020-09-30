// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_data_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListData _$ListDataFromJson(Map<String, dynamic> json) {
  return ListData(
    json['total'] as int,
    json['per_page'] as int,
    json['current_page'] as int,
    json['last_page'] as int,
    json['data'] as List,
  );
}

Map<String, dynamic> _$ListDataToJson(ListData instance) => <String, dynamic>{
      'total': instance.total,
      'per_page': instance.perPage,
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'data': instance.data,
    };
