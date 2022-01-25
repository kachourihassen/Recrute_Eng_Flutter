import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Rdv.g.dart';
@JsonSerializable()
class Rdv {

  String idd;
  String id;
  String idC;
  String idR;
  String time;
  String date;
  String emailC;
  String code;
  String nomC;
  String status;

  Rdv({this.idd, this.id, this.idC, this.idR, this.time, this.date, this.emailC, this.code, this.nomC, this.status});

  factory Rdv.fromJson(Map<String, dynamic> json) =>
      _$RdvFromJson(json);
  Map<String, dynamic> toJson() => _$RdvToJson(this);

}