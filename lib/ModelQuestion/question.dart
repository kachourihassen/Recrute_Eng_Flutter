import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Question.g.dart';
@JsonSerializable(explicitToJson: true)
class Questionmain extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

  }

}

class Question extends StatelessWidget {
  //var
  String type;
  String Questin;
  String reponse1;
  String reponse2;
  String reponse3;
  String reponse4;
  String a1;
  String a2;
  String a3;
  String a4;

  //constructor
  Question({this.type,this.Questin, this.reponse1, this.reponse2, this.reponse3, this.reponse4, this.a1, this.a2, this.a3, this.a4});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: [
          Text('Question'),


        ],),
    );
  }


  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}