import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionuser/ModelQuestion/answers.dart';
import 'package:gestionuser/ModelQuestion/question.dart';

import 'package:gestionuser/Pages/MehdiPage/pages/rendezvous.dart';
import 'package:http/http.dart' as http;
import 'package:timer_count_down/timer_controller.dart';

final isRestart = StateProvider((ref) => false);
final isPause = StateProvider((ref) => false);
void main() => runApp(AfficheQuiz());

class AfficheQuiz extends StatefulWidget {
  @override
  _MyAfficheQuiz createState() => _MyAfficheQuiz(nom);
  String nom;
  AfficheQuiz({Key key, @required this.nom}) : super(key: key);
}

class _MyAfficheQuiz extends State<AfficheQuiz> {
  String nom;
  _MyAfficheQuiz(String o) {
    this.nom = o;
  }
  Timer _timer;
  int _start = 100;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    yourFunction();
    super.initState();
  }

  //var
  String _Questin;
  String _reponse1;
  String _reponse2;
  String _reponse3;
  String _reponse4;
  List<bool> checkValue = [false, false, false, false, false, false, false];
  List<Question> QuizList = [];
  List<answers> answerss = [];
  int score = 0;
  List<dynamic> caches;
  var fList;
  final _controller = CountdownController();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  int _counter = 120;
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    increamentCounter();
    for (int i = 0; i <= QuizList.length; i++)
      answerss.add(new answers(false, false, false, false));

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Répondre a Quiz                 ' + '$_counter'),
      ),
      body: ListView(children: [
        new ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: QuizList.length,
            itemBuilder: (BuildContext cntxt, int index) {
              return new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: new BoxDecoration(
                      color: Color(0xff0069a7),
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: ClipRRect(
                      child: Text(
                        'Question: ' + QuizList[index].Questin,
                        style: TextStyle(color: CupertinoColors.white),
                      ),
                    ),
                  ),
                  new Row(
                    children: [
                      new Checkbox(
                          value: answerss[index].reponse1,
                          onChanged: (bool newValue1) {
                            answerss[index].reponse1 = newValue1;
                            setState(() {
                              if (answerss[index].reponse1.toString() ==
                                  QuizList[index].reponse1) {
                                score++;
                              } else {
                                score--;
                                print(answerss[index].reponse1.toString());
                                print(QuizList[index].reponse1);
                              }
                            });
                          }),
                      new Text(
                        QuizList[index].a1,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  new Row(
                    children: [
                      new Checkbox(
                          value: answerss[index].reponse2,
                          onChanged: (bool newValue) {
                            answerss[index].reponse2 = newValue;
                            setState(() {
                              if (answerss[index].reponse2.toString() ==
                                  QuizList[index].reponse2) {
                                score++;
                              } else {
                                score--;
                                print(answerss[index].reponse2.toString());
                                print(QuizList[index].reponse2);
                              }
                            });
                          }),
                      new Text(
                        QuizList[index].a2,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  new Row(
                    children: [
                      new Checkbox(
                          value: answerss[index].reponse3,
                          onChanged: (bool newValue2) {
                            answerss[index].reponse3 = newValue2;
                            setState(() {
                              if (answerss[index].reponse3.toString() ==
                                  QuizList[index].reponse3) {
                                score++;
                              } else {
                                score--;
                                print(answerss[index].reponse3.toString());
                                print(QuizList[index].reponse3);
                              }
                            });
                          }),
                      new Text(
                        QuizList[index].a3,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                  new Row(
                    children: [
                      new Checkbox(
                          value: answerss[index].reponse4,
                          onChanged: (bool newValue3) {
                            answerss[index].reponse4 = newValue3;
                            setState(() {
                              if (answerss[index].reponse4.toString() ==
                                  QuizList[index].reponse4) {
                                score++;
                              } else {
                                score--;
                                print(answerss[index].reponse4.toString());
                                print(QuizList[index].reponse4);
                              }
                            });
                          }),
                      new Text(
                        QuizList[index].a4,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
        Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: RaisedButton(
                child: Text("Submit"),
                onPressed: _counter > 0
                    ? () {
                        int i = 0;
                        /* for(Question q in QuizList){
                          q.reponse1=answerss[i].reponse1;
                          q.reponse2=answerss[i].reponse2;
                          q.reponse3=answerss[i].reponse3;
                          q.reponse4=answerss[i].reponse4;
                          i++;
                          save(q);}*/
                        print(score);
                        saveAnswer(score.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    : null))
      ]),
    ));
  }

  Future<List<Question>> getQcm() async {
    final urlList = ["http://192.168.1.3:5000/question/findquestion"];
    print("dfdfg");
    final responses = await Future.wait(
      urlList.map((String url) {
        return http.get(url);
      }),
    );

    caches = responses.map((response) {
      return (json.decode(response.body) as List)
          .map((data) => Question.fromJson(data))
          .toList();
    }).toList();
    print(caches[0]);
    fList = List<Question>.from(caches[0]);
    //for(Offer titre in fList )
    //offerTitre.add("titre.titre");
    Question quiz = new Question();
    for (Question q in fList) {
      quiz.type = q.type;
      quiz.Questin = q.Questin;
      quiz.reponse1 = q.reponse1;
      quiz.reponse1 = q.reponse2;
      quiz.reponse1 = q.reponse3;
      quiz.reponse1 = q.reponse4;
      quiz.a1 = q.a1;
      quiz.a2 = q.a2;
      quiz.a3 = q.a3;
      quiz.a4 = q.a4;
      print(quiz.a1);
      // QuizList.add(quiz);
    }
    return fList;
  }

  void yourFunction() async {
    QuizList = await getQcm();
    print('dfdf');
  }

  increamentCounter() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        if (_counter > 0) _counter--;
      });
    });
  }

  void saveAnswer(String score) async {
    final response = await http.post(
      "http://192.168.1.3:5000/answer/ajoutAnswer",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "score": score.toString(),
        "nom": "nom condidat",
        "email": "email condidat",
        "nomOffer": nom,
      }),
    );

    if (response.statusCode == 200) {
    } else {
      throw Exception(response.statusCode);
    }
  }
}
