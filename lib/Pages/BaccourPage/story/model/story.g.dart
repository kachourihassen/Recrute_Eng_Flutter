// GENERATED CODE - DO NOT MODIFY BY HAND


part of 'Story.dart';
// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************







Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(

    user: json['user'] as String,
    caption: json['descpost'] as String,
    url: json['nomentr'] as String,

  );
}

Map<String, dynamic> _$StoryToJson(Story instance) =>
    <String, dynamic>{
      'user': instance.user,
      'caption': instance.caption,
      'url': instance.url,

    };
