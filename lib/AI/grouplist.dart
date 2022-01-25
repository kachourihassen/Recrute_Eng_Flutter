import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:gestionuser/ModelAnnonce1/Offer.dart';

import 'package:gestionuser/Pages/HomePage.dart';

import '../NetworkHandler.dart'; //used for fullscreen

class AwesomeApp extends StatefulWidget {
  final String id;
  final String tot;
  final String a;
  final String b;
  final String c;

  AwesomeApp(this.id, this.tot, this.a, this.b, this.c);

  @override
  _AwesomeAppState createState() => _AwesomeAppState();
}

class _AwesomeAppState extends State<AwesomeApp> with TickerProviderStateMixin {
  AnimationController controller;
  NetworkHandler networkHandler = NetworkHandler();
  bool circular = true;
  List<String> listtitre = [] ?? null;
  List<String> listeexp = [] ?? null;
  List<String> listeskill = [] ?? null;
  Offer offreModel = Offer();
  List<List<Color>> colors = <List<Color>>[
    [
      Colors.redAccent,
      Colors.red[200],
    ],
    [
      Colors.pinkAccent,
      Colors.pink[200],
    ],
    [
      Colors.orangeAccent,
      Colors.orange[200],
    ],
    [
      Colors.purpleAccent,
      Colors.purple[200],
    ],
    [Colors.cyanAccent, Colors.cyan[200]]
  ];
  @override
  void initState() {
    circular = true;
    dataoffers();
    // sleep(Duration(seconds: 1));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void dataoffers() async {
    for (var i = 1; i <= widget.id.split(" ").length - 1; i++) {
      var response =
          await networkHandler.get("/offer/id/" + widget.id.split(" ")[i]);
      offreModel = Offer.fromJson(response["data"]);

      setState(() {
        listtitre.add(offreModel.titre);
        listeexp.add(offreModel.experience);
        listeskill.add(offreModel.skill);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue],
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false)),
                      ],
                    ),
                  )),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blue[200]],
                  ),
                ),
                child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "List of Offers",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ListView.builder(
                        itemCount: widget.id.split(" ").length -
                            1, //total no of list items
                        itemBuilder: (BuildContext context, int currentitem) {
                          return GestureDetector(
                            onTap: () {
                              print(widget.id.split(" ")[currentitem + 1]);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => baccour(),
                              // ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors:
                                        colors[currentitem % colors.length]),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  new BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 3.5,
                                      offset: new Offset(1.0, 2.0)),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 10),
                              height: 120,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        margin:
                                            EdgeInsets.only(left: 20, top: 15),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.brown.shade800,
                                          child: Text('OFFERS'),
                                          //radius: 25,
                                        )),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.only(top: 20, left: 5),
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 4,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    DelayedDisplay(
                                                      delay:
                                                          Duration(seconds: 1),
                                                      child: new Text(
                                                        widget.a.split("*")[
                                                            currentitem + 1],
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    DelayedDisplay(
                                                      delay:
                                                          Duration(seconds: 1),
                                                      child: Text(
                                                        widget.b.split("*")[
                                                            currentitem + 1],
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    DelayedDisplay(
                                                      delay:
                                                          Duration(seconds: 1),
                                                      child: Text(
                                                        widget.c.split("*")[
                                                            currentitem + 1],
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.0,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          DelayedDisplay(
                                            delay: Duration(seconds: 1),
                                            child: Text(
                                              widget.tot
                                                  .split(" ")[currentitem + 1],
                                              style: TextStyle(fontSize: 22),
                                            ),
                                          ),
                                          Text("Of 100%")
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
