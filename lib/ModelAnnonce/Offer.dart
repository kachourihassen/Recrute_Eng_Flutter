import 'package:json_annotation/json_annotation.dart';
part 'Offer.g.dart';

@JsonSerializable()
class Data {
  List<Offer> data;
  Data({this.data});
}

class Offer {
  String id;
  String user;
  String nomentr;
  String post;
  String anexp;
  String descentr;
  String descpost;
  String typecont;
  String sexe;
  String adress;
  String salaire;
  String skills;

  Offer(
      {this.id,
      this.user,
      this.nomentr,
      this.post,
      this.anexp,
      this.descentr,
      this.descpost,
      this.typecont,
      this.sexe,
      this.adress,
      this.salaire,
      this.skills});

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
  Map<String, dynamic> toJson() => _$OfferToJson(this);
}
