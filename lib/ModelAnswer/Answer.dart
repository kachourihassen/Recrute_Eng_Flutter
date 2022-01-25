import 'package:json_annotation/json_annotation.dart';
part 'Answer.g.dart';

@JsonSerializable()
class AnswerData {
  List<Answer> answerData;
  AnswerData({this.answerData});
}

class Answer {
  String score;
  String nom;
  String email;
  String nomOffer;


  Answer(
      {
        this.score,
        this.nom,
        this.email,
        this.nomOffer,
        });

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
