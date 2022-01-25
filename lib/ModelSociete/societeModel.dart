import 'package:json_annotation/json_annotation.dart';

part 'societeModel.g.dart';

@JsonSerializable()
class SocieteModel {
  String name;
  String username;
  String profession;
  String date;
  String titleline;
  String about;
  SocieteModel(
      {this.date,
      this.about,
      this.name,
      this.profession,
      this.titleline,
      this.username});

  factory SocieteModel.fromJson(Map<String, dynamic> json) =>
      _$SocieteModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocieteModelToJson(this);
}
