import 'package:flutter/material.dart';
import 'package:gestionuser/ModelSociete/societeModel.dart';

import 'package:gestionuser/Pages/HomeRec.dart';

import '../NetworkHandler.dart';

class MainSociete extends StatefulWidget {
  MainSociete({Key key}) : super(key: key);

  @override
  _MainSocieteState createState() => _MainSocieteState();
}

class _MainSocieteState extends State<MainSociete> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  SocieteModel societeModel = SocieteModel();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/societe/getData/societe");
    setState(() {
      societeModel = SocieteModel.fromJson(response["data"]);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xffEEEEFF),
        appBar: AppBar(
          title: Text("My Company"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBackClick,
          ),
        ),
        body: circular
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: double.infinity,
                height: size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/images/main_top.png",
                        width: size.width * 0.35,
                      ),
                    ),
                    head(),
                    SizedBox(height: size.height * 0.05),
                    SizedBox(
                      height: 20,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/login_bottom.png",
                        width: size.width * 0.4,
                      ),
                    ),
                  ],
                ),
              ));
  }

  Widget head() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkHandler().getImage(societeModel.username),
            ),
          ),
          Text(
            societeModel.username,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(societeModel.titleline),
          Divider(
            thickness: 0.8,
          ),
          otherDetails("About", societeModel.about),
          otherDetails("Name", societeModel.name),
          otherDetails("Phone", societeModel.profession),
          otherDetails("Date", societeModel.date),
          Divider(
            thickness: 0.8,
          ),
        ],
      ),
    );
  }

  Widget otherDetails(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$label :",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  onBackClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomeRecPage(),
    ));
  }

  Widget build1() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                height: size.height,
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/main_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/login_bottom.png",
                      width: size.width * 0.4,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                ]))));
  }
}
