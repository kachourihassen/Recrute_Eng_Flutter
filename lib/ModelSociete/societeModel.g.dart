// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'societeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocieteModel _$SocieteModelFromJson(Map<String, dynamic> json) {
  return SocieteModel(
    date: json['date'] as String,
    about: json['about'] as String,
    name: json['name'] as String,
    profession: json['profession'] as String,
    titleline: json['titleline'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$SocieteModelToJson(SocieteModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'profession': instance.profession,
      'date': instance.date,
      'titleline': instance.titleline,
      'about': instance.about,
    };
