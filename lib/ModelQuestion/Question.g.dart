// GENERATED CODE - DO NOT MODIFY BY HAND


part of 'question.dart';
// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************




Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question(
    type: json['type'] as String,
    Questin: json['question'] as String,
    a1: json['answer1'] as String,
    a2: json['answer2'] as String,
    a3: json['answer3'] as String,
    a4: json['answer4'] as String,
    reponse1: json['reponse1'] as String,
    reponse2: json['reponse2'] as String,
    reponse3: json['reponse3'] as String,
    reponse4: json['reponse4'] as String,
  );
}

Map<String, dynamic> _$QuestionToJson(Question instance) =>
    <String, dynamic>{

      'type': instance.type,
      'Questin': instance.Questin,
      'reponse1': instance.a1,
      'reponse2': instance.a2,
      'reponse3': instance.a3,
      'reponse4': instance.a4,
      'a1': instance.reponse1,
      'a2': instance.reponse2,
      'a3': instance.reponse3,
      'a4': instance.reponse4,

    };