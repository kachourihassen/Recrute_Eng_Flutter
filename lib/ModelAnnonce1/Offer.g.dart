// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Offer.dart';
// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return Offer(
    id: json['_id'] as String,
    user: json['user'] as String,
    description: json['descpost'] as String,
    titre: json['nomentr'] as String,
    skill: json['skills'] as String,
    experience: json['anexp'] as String,
    post: json['poste'] as String,
    descentr: json['descentr'] as String,
    typecont: json['typecont'] as String,
    sexe: json['sexe'] as String,
    adresse: json['adress'] as String,
    salaire: json['salaire'] as String,
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'descpost': instance.description,
      'nomentr': instance.titre,
      'skills': instance.skill,
      'anexp': instance.experience,
      'poste': instance.post,
      'descentr': instance.descentr,
      'typecont': instance.typecont,
      'sexe': instance.sexe,
      'adresse': instance.adresse,
      'salaire': instance.salaire,
    };
