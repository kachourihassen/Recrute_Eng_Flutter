import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gestionuser/ModelAnswer/Answer.dart';
import 'package:gestionuser/ModelUser/userModel.dart';
import 'package:random_string/random_string.dart';
import 'package:http/http.dart' as http;
import 'package:gestionuser/Pages/MehdiPage/model/Rdv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../../NetworkHandler.dart';

void main() => runApp(DateTimePicker());
final networkHandler = NetworkHandler();

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> caches;
  List<Answer> fList;
  List<Answer> AnswerList = [];
  String _date = "Not set";
  String _time = "Not set";
  TextStyle text = TextStyle(fontSize: 30);
  String codee = "Not set";
  String username = "";
  UserModel userModel = UserModel();

  @override
  void initState() {
    yourFunction().then((value) {
      AnswerList = value;
      setState(() {
        print("***********");
      });
    });

    super.initState();
  }

  void checkProfile1() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {});
    } else {
      setState(() {});
      datauser;
    }
  }

  void datauser() async {
    var response = await networkHandler.get("/user/" + username.toString());
    userModel = UserModel.fromJson(response["data"]);

    setState(() {
      String email = userModel.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Add a Meet")),
      backgroundColor: Colors.lightBlueAccent,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 0.0,
              ),
              Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: new AssetImage("assets/images/teammeet.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2023, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    _date = '${date.year} - ${date.month} - ${date.day}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.date_range,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_date",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showTitleActions: true, onConfirm: (time) {
                    print('confirm $time');
                    _time = '${time.hour} : ${time.minute} : ${time.second}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_time",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height - 400,
            child: ListView.builder(
              itemCount: AnswerList.length,
              padding: const EdgeInsets.only(top: 8),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                print("ListView.builder");
                print(AnswerList[index]);

                return Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "  Name:" + AnswerList[index].nom,
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "  Email:" + AnswerList[index].email,
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "  Score:" + AnswerList[index].score,
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                    RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        elevation: 4.0,
                        child: Text(("Send Meet!"),
                            style: TextStyle(color: Colors.white)),
                        color: Colors.pinkAccent,
                        onPressed: () {
                          randomize();
                          Rdv rdv = new Rdv();

                          rdv.code = codee;
                          rdv.time = _time;
                          rdv.date = _date;
                          rdv.emailC = AnswerList[index].email;
                          rdv.idR = "10";
                          rdv.idC = AnswerList[index].nomOffer;
                          rdv.id = userModel.email;
                          rdv.nomC = AnswerList[index].nom;
                          rdv.status = "Pending";

                          SetAMeet(rdv);
                        }),
                  ]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  void randomize() {
    codee =
        randomAlpha(4) + randomNumeric(2) + randomAlpha(4) + randomNumeric(3);
  }

  void SetAMeet(Rdv rdv) async {
    print("dfv");
    final response = await http.post(
      "http://192.168.209.157:5000/Rdv/AjoutRdv",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "id": rdv.id,
        "idC": rdv.idC,
        "idR": rdv.idR,
        "time": rdv.time,
        "date": rdv.date,
        "code": rdv.code,
        "emailC": rdv.emailC,
        "nomC": rdv.nomC,
        "status": rdv.status,
      }),
    );

    if (response.statusCode == 200) {
      print(rdv.id);
      sendMAil(rdv);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(' Notification'),
                content: Text('Added Successfully'),
              ));
    } else {
      throw Exception(response.statusCode);
    }
  }

  sendMAil(Rdv rdv) async {
    String username = 'noreplyrecruitengine@gmail.com';
    String password = 'scarlet9874';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(rdv.emailC)
      ..subject = 'Your Online Meeting ${DateTime.now()}'
      ..text =
          'Hello, thank you for submitting your CV.\n You will find the details of our meeting here. \n The room code name and date .'
      ..html = "<h2>Hello Mr. </h2> " +
          rdv.nomC +
          " <h3> \n Thank you for submitting your CV,</h2> \n <h3> Here is your meet date: </h3>" +
          rdv.date +
          " <p> \n You will find the details of our meeting here, your room code name: \n  </p>" +
          rdv.code;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<List<Answer>> getAnswers() async {
    final urlList = ["http://192.168.209.157:5000/answer/findAnswer"];
    print("////////////////////////////");
    final responses = await Future.wait(
      urlList.map((String url) {
        return http.get(url);
      }),
    );

    caches = responses.map((response) {
      return (json.decode(response.body) as List)
          .map((data) => Answer.fromJson(data))
          .toList();
    }).toList();
    print(caches[0]);
    fList = List<Answer>.from(caches[0]);
    //for(Offer titre in fList )
    //offerTitre.add("titre.titre");
    Answer answer = new Answer();
    for (Answer q in fList) {
      answer.score = q.score;
      answer.nom = q.nom;
      answer.email = q.email;
      answer.nomOffer = q.nomOffer;
      //print(quiz.a1);
      // QuizList.add(quiz);
    }
    return fList;
  }

  Future<List<Answer>> yourFunction() {
    return getAnswers();

    print('dfdf');
  }
}
