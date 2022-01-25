part of 'Offer.dart';

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return Offer(
    id: json['_id'] as String,
    user: json['user'] as String,
    nomentr: json['nomentr'] as String,
    post: json['poste'] as String,
    anexp: json['anexp'] as String,
    descentr: json['descentr'] as String,
    descpost: json['descpost'] as String,
    typecont: json['typecont'] as String,
    sexe: json['sexe'] as String,
    adress: json['adress'] as String,
    salaire: json['salaire'] as String,
    skills: json['skills'] as String,
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) => <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'nomentr': instance.nomentr,
      'poste': instance.post,
      'anexp': instance.anexp,
      'descentr': instance.descentr,
      'descpost': instance.descpost,
      'typecont': instance.typecont,
      'sexe': instance.sexe,
      'adress': instance.adress,
      'salaire': instance.salaire,
      'skills': instance.skills,
    };
