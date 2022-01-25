import 'package:json_annotation/json_annotation.dart';

part 'cvModel.g.dart';

@JsonSerializable()
class CvModel {
  String username;
  String lastname;
  String title;
  String email;
  String mobile;
  String adress;
  String date;
  String about;
  String education;
  String skills;
  String experience;
  String intere;
  String reference;
  CvModel(
      {this.username,
      this.lastname,
      this.title,
      this.email,
      this.mobile,
      this.adress,
      this.date,
      this.about,
      this.education,
      this.skills,
      this.experience,
      this.intere,
      this.reference});

  factory CvModel.fromJson(Map<String, dynamic> json) =>
      _$CvModelFromJson(json);
  Map<String, dynamic> toJson() => _$CvModelToJson(this);
}
