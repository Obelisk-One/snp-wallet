// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_data_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultData _$ResultDataFromJson(Map<String, dynamic> json) {
  return ResultData(
    json['code'] as int,
    json['msg'] as String,
    json['time'] as int,
    json['data'],
  )..error = false;
}

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'time': instance.time,
      'data': instance.data,
      'error': instance.error,
    };
