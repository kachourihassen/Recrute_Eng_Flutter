import 'package:json_annotation/json_annotation.dart';
part 'Offer.g.dart';

@JsonSerializable()
class Offer {
  String id;
  String user;
  String description;
  String titre;
  String skill;
  String experience;
  String post;
  String descentr;
  String typecont;
  String sexe;
  String adresse;
  String salaire;

  Offer(
      {this.id,
      this.user,
      this.description,
      this.titre,
      this.skill,
      this.experience,
      this.post,
      this.descentr,
      this.typecont,
      this.sexe,
      this.adresse,
      this.salaire});

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
