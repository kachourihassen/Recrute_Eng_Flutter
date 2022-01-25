part of 'Rdv.dart';
// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



Rdv _$RdvFromJson(Map<String, dynamic> json) {
  return Rdv(
    idd: json['_id'] as String,
    id: json['id'] as String,
    idC: json['idC'] as String,
    idR: json['idR'] as String,
    time: json['time'] as String,
    date: json['date'] as String,
    emailC: json['emailC'] as String,
    code: json['code'] as String,
    nomC: json['nomC'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$RdvToJson(Rdv instance) =>
    <String, dynamic>{
      'idd': instance.idd,
      'id': instance.id,
      'idC': instance.idC,
      'idR': instance.idR,
      'time': instance.time,
      'date': instance.date,
      'emailC': instance.emailC,
      'code': instance.code,
      'nomC': instance.nomC,
      'status': instance.nomC,

    };
