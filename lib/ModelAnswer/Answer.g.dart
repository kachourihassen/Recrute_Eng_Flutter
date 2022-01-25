part of 'Answer.dart';

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer(
    score: json['score'] as String,
    nom: json['nom'] as String,
    email: json['email'] as String,
    nomOffer: json['nomOffer'] as String,

  );
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
  'score':instance.score,
  'nom': instance.nom,
  'email': instance.email,
  'nomOffer': instance.nomOffer,

};
