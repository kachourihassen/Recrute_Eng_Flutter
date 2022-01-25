import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionuser/ModelUser/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/ListOfMeets.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/NetworkHandler.dart';
import 'package:gestionuser/Pages/MehdiPage/model/Rdv.dart';

final isRestart = StateProvider((ref) => false);
final isPause = StateProvider((ref) => false);

void main() => runApp(Invitation());

class Invitation extends StatefulWidget {
  @override
  _Invitation createState() => _Invitation();
}

class _Invitation extends State<Invitation> {
  //var
  String time;
  String date;
  String emailC;
  String code;
  String nomC;
  String status;
  String _idd;
  String username = "";
  final networkHandler = NetworkHandler();
  UserModel userModel = UserModel();

  List<dynamic> caches;
  var fList;
  List<Rdv> ilist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yourFunction().then((value) {
      ListOfMeets.M = value;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {});
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
    //Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(" Check your Invitations")),
        backgroundColor: Colors.lightBlueAccent,
        body: Center(
          //child: GridView.count(

          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          //crossAxisCount: 1,
          // Generate 100 widgets that display their index in the List.
          //children: List.generate((ListOfMeets.M.length), (index) {
          child: new ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: ListOfMeets.M.length,
              itemBuilder: (BuildContext cntxt, int indexx) {
                return new Column(children: <Widget>[
                  Center(
                    child: Container(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60.0,
                          ),
                          /*Container(
                        decoration: BoxDecoration(color: Colors.white,

                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40.0),
                              topLeft: Radius.circular(40.0)),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        width: 300.0,
                        height: 50.0,
                        child: Text("Name: " +
                            ListOfMeets.M.elementAt(index).nomC,
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),

                      ),*/
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0)),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            width: 300.0,
                            height: 50.0,
                            child: Text(
                              "From: " + ListOfMeets.M[indexx].emailC,
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            width: 300.0,
                            height: 50.0,
                            color: Colors.white,
                            child: Text(
                              "Date: " + ListOfMeets.M[indexx].date,
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            width: 300.0,
                            height: 50.0,
                            color: Colors.white,
                            child: Text(
                              "Time: " + ListOfMeets.M[indexx].time,
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(60.0),
                                  bottomRight: Radius.circular(60.0)),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            width: 300.0,
                            height: 90.0,
                            child: Text(
                              "Room Name: " + ListOfMeets.M[indexx].code,
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            width: 220.0,
                            height: 50.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                elevation: 4.0,
                                child: Text(("Accept"),
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.green,
                                onPressed: () {
                                  accept(indexx);
                                  AcceptMAil(indexx);
                                }),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            width: 220.0,
                            height: 50.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                elevation: 4.0,
                                child: Text(("Refuse"),
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.red,
                                onPressed: () {
                                  refuse(indexx);
                                  RefuseMAil(indexx);
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                ]);
              }),
        ),
      ),
      //),
    );
  }

  Future<List<Rdv>> getMeets() async {
    final urlList = ["http://192.168.209.157:5000/Rdv/findRdv"];
    print("bobo");
    final responses = await Future.wait(
      urlList.map((String url) {
        return http.get(url);
      }),
    );

    caches = responses.map((response) {
      return (json.decode(response.body) as List)
          .map((data) => Rdv.fromJson(data))
          .toList();
    }).toList();
    //print(caches[0]);
    fList = List<Rdv>.from(caches[0]);
    //for(Offer titre in fList )
    //offerTitre.add("titre.titre");
    Rdv rdv = new Rdv();

    for (Rdv r in fList) {
      if (r.status == "Pending" && r.emailC == userModel.email) {
        rdv.id = r.id;
        rdv.date = r.date;
        rdv.time = r.time;
        rdv.code = r.code;
        rdv.emailC = r.emailC;
        rdv.nomC = r.nomC;
        rdv.status = r.status;
        //ilist.add(rdv);
        //print(ilist.length);
        //print(ilist[ilist.length-1].id);

      }
    }
    return fList;
  }

  Future<List<Rdv>> yourFunction() {
    return getMeets();
  }

  accept(nbr) async {
    Map<String, String> data = {"status": "Accepted!"};

    var response = await networkHandler.patch(
        "/Rdv/updaterdv/${ListOfMeets.M[nbr].idd}", data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("/Rdv/updaterdv/${ListOfMeets.M[nbr].idd}");
    }
  }

  void refuse(fs) async {
    Map<String, String> data = {"status": "Refused!"};

    var response = await networkHandler.patch(
        "/Rdv/updaterdv/${ListOfMeets.M[fs].idd}", data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("/Rdv/updaterdv/${ListOfMeets.M[fs].idd}");
    }
  }

  AcceptMAil(acc) async {
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
      ..recipients.add(ListOfMeets.M[acc].id)
      ..subject = 'Result Of Your Online Meeting Request : ${DateTime.now()}'
      ..text =
          'Hello, thank you for submitting your CV.\n You will find the details of our meeting here. \n The room code name and date .'
      ..html = "<h2>Hello Mr. </h2> " +
          ListOfMeets.M[acc].nomC +
          " <h3> \n Here is the result of your request: </h2>" +
          "The meet has been Accepted!" +
          " \n <h3> Here is your meet date: </h3>" +
          ListOfMeets.M[acc].date +
          " <p> \n You will find the details of your meeting here, your room code name: \n  </p>" +
          ListOfMeets.M[acc].code;

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

  RefuseMAil(ref) async {
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
      ..recipients.add(ListOfMeets.M[ref].id)
      ..subject = 'Result Of Your Online Meeting Request : ${DateTime.now()}'
      ..text =
          'Hello, thank you for submitting your CV.\n You will find the details of our meeting here. \n The room code name and date .'
      ..html = "<h2>Hello Mr. </h2> " +
          ListOfMeets.M[ref].id +
          " <h3> \n Here is the result of your request: </h2>" +
          "The meet has been Refused!";

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
}
