import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestionuser/ModelUser/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:gestionuser/Pages/MehdiPage/pages/ListOfMeets.dart';
import 'package:gestionuser/Pages/MehdiPage/model/Rdv.dart';

import '../../../NetworkHandler.dart';

final isRestart = StateProvider((ref) => false);
final isPause = StateProvider((ref) => false);

void main() => runApp(AfficheMeetC());

class AfficheMeetC extends StatefulWidget {
  @override
  _MyAfficheMeetC createState() => _MyAfficheMeetC();
}

class _MyAfficheMeetC extends State<AfficheMeetC> {
  //var
  String time;
  String date;
  String emailC;
  String code;
  String nomC;
  String status;
  String id;
  List<dynamic> caches;
  var fList;
  String username = "";
  final networkHandler = NetworkHandler();
  UserModel userModel = UserModel();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yourFunction().then((value) {
      ListOfMeets.M = value;
      setState(() {});
    });
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

    yourFunction();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text(" Check your Meets")),
        backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 1,
            // Generate 100 widgets that display their index in the List.
            children: List.generate((ListOfMeets.M.length), (index) {
              return Center(
                child: Container(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 60.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(80.0),
                              topLeft: Radius.circular(80.0)),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        width: 300.0,
                        height: 50.0,
                        child: Text(
                          "Name: " + ListOfMeets.M.elementAt(index).nomC,
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
                          "Email: " + ListOfMeets.M.elementAt(index).id,
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
                          "Date: " + ListOfMeets.M.elementAt(index).date,
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
                          "Time: " + ListOfMeets.M.elementAt(index).time,
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
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0)),
                        ),
                        padding: const EdgeInsets.all(12.0),
                        width: 300.0,
                        height: 90.0,
                        child: Text(
                          "Room Name: " + ListOfMeets.M.elementAt(index).code,
                          style: TextStyle(
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
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
      if (r.emailC == userModel.email && r.status == ("Accepted!")) {
        rdv.id = r.id;
        rdv.date = r.date;
        rdv.time = r.time;
        rdv.code = r.code;
        rdv.emailC = r.emailC;
        rdv.nomC = r.nomC;
        rdv.status = r.status;
        print(rdv.code);
        // QuizList.add(quiz);
      }
    }
    return fList;
  }

  Future<List<Rdv>> yourFunction() async {
    print("Loaded");
    return getMeets();
  }
}
