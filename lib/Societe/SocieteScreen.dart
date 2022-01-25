import 'package:flutter/material.dart';

import 'package:gestionuser/Pages/HomeRec.dart';

import '../NetworkHandler.dart';
import 'CreatSociete.dart';
import 'MainSociete.dart';

class SocieteScreen extends StatefulWidget {
  SocieteScreen({Key key}) : super(key: key);

  @override
  _SocieteScreenState createState() => _SocieteScreenState();
}

class _SocieteScreenState extends State<SocieteScreen> {
  NetworkHandler networkHandler = NetworkHandler();
  Widget page = CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    checkSociete();
  }

  void checkSociete() async {
    var response = await networkHandler.get("/societe/checkSociete");
    if (response["status"] == true) {
      setState(() {
        page = MainSociete();
      });
    } else {
      setState(() {
        page = button();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEFF),
      body: page,
    );
  }

  Widget showSociete() {
    return Center(child: Text("Company Data is Avalable"));
  }

  Widget button() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
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
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          SizedBox(height: size.height * 0.05),
          SizedBox(
            height: 10,
          ),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.white10,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomeRecPage()),
                  );
                }),
          ),
          InkWell(
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreatSociete()))
                  },
              child: Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: new InkWell(
                    child: new Center(
                  child: new Text(
                    "Add Company",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )),
              )),
        ],
      ),
    )));
  }
}
