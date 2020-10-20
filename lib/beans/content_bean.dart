/*
 * @Project:        snp
 * @Package:        beans
 * @FileName:       content_bean
 * @Create:         2020/10/20 3:36 PM
 * @Description:    
 * @author          dt
*/
import 'package:json_annotation/json_annotation.dart';

part 'content_bean.g.dart';


List<ContentBean> getContentBeanList(List<dynamic> list){
  List<ContentBean> result = [];
  list.forEach((item){
    result.add(ContentBean.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class ContentBean extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'comments')
  int comments;

  @JsonKey(name: 'createtime')
  int createtime;

  @JsonKey(name: 'updatetime')
  int updatetime;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'topic')
  Topic topic;

  ContentBean(this.id,this.message,this.images,this.comments,this.createtime,this.updatetime,this.username,this.nickname,this.avatar,this.topic,);

  factory ContentBean.fromJson(Map<String, dynamic> srcJson) => _$ContentBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentBeanToJson(this);

}


@JsonSerializable()
class Topic extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'comments')
  int comments;

  @JsonKey(name: 'createtime')
  int createtime;

  @JsonKey(name: 'updatetime')
  int updatetime;

  @JsonKey(name: 'username')
  String username;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  Topic(this.id,this.message,this.images,this.comments,this.createtime,this.updatetime,this.username,this.nickname,this.avatar,);

  factory Topic.fromJson(Map<String, dynamic> srcJson) => _$TopicFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TopicToJson(this);

}


