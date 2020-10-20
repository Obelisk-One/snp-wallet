// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentBean _$ContentBeanFromJson(Map<String, dynamic> json) {
  return ContentBean(
    json['id'] as int,
    json['message'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['comments'] as int,
    json['createtime'] as int,
    json['updatetime'] as int,
    json['username'] as String,
    json['nickname'] as String,
    json['avatar'] as String,
    (json['topic'] == null || (json['topic'] is String))
        ? null
        : Topic.fromJson(json['topic'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ContentBeanToJson(ContentBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'images': instance.images,
      'comments': instance.comments,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'username': instance.username,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'topic': instance.topic,
    };

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
    json['id'] as int,
    json['message'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['comments'] as int,
    json['createtime'] as int,
    json['updatetime'] as int,
    json['username'] as String,
    json['nickname'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'images': instance.images,
      'comments': instance.comments,
      'createtime': instance.createtime,
      'updatetime': instance.updatetime,
      'username': instance.username,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
    };
