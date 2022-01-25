import 'package:flutter/material.dart';
import 'package:gestionuser/AI/listcv.dart';
import 'package:gestionuser/NetworkHandler.dart';
import 'package:gestionuser/NetworkHandler1.dart';
import 'package:gestionuser/Pages/HomePage.dart';
import 'package:gestionuser/Pages/YassinePage/PaiementPage.dart';
import 'package:gestionuser/Pages/YassinePage/constants.dart';
import 'package:gestionuser/Pages/YassinePage/data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DetailPaiement extends StatefulWidget {
  final PlanetInfo planetInfo;

  const DetailPaiement({Key key, this.planetInfo}) : super(key: key);

  @override
  _DetailPaiementState createState() => _DetailPaiementState();
}

class _DetailPaiementState extends State<DetailPaiement> {
  String username = "";
  String upgrade = "";
  String account = "";
  @override
  void initState() {
    checkProfile1();
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
    }
    checkuser();
  }

  void checkuser() async {
    var response1 = await networkHandler.get("/user/" + username.toString());
    //RegExp _a = new RegExp(r"(default|gold)", caseSensitive: false);
    //String _a1 = _a.stringMatch(response1.toString()).toString();

    Map<String, dynamic> v = response1["data"];
    print(v["email"]);
    upgrade = v["upgrade"];
    account = v["acount"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PaiementPage()),
                    (route) => false)),
      ),
      backgroundColor: const Color(0xffb9f6ca),
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(),
              Positioned(
                //right: -500,
                child: Image.asset(widget.planetInfo.iconImage),
              ),
              Positioned(
                top: 120,
                left: 5,
                child: Text(
                  widget.planetInfo.prix,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 120,
                    color: Colors.blue[900],
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 250),
                        Text(
                          widget.planetInfo.name,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 23,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Upgrade Now',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 23,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Divider(color: Colors.black38),
                        Text(
                          'Description : ',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 23,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          widget.planetInfo.description ?? '',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 20,
                            color: contentTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          widget.planetInfo.description1 ?? '',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 20,
                            color: contentTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 40),
                        Divider(color: Colors.black38),
                        Container(
                          height: 50.0,
                          margin: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: () async {
                              Map<String, dynamic> data = {
                                "amount": widget.planetInfo.prix,
                                "sender": account,
                                "receiver":
                                "0xdc5014026682bea40ccbba53fd6b4140cbf430d5"
                              };
                              Map<String, dynamic> data2 = {
                                "upgrade": widget.planetInfo.name
                              };
                              await NetworkHandler1().post1("/sendCoin", data);
                              print("Succes paiement");
                              await NetworkHandler().patch1(
                                  "/user/updateupgrade/" + username, data2);
                              print("Succes Upgrade");
                              /*  Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaiementPage()),
                                  (route) => false);*/
                              Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Succes",
                                desc: "Upgrade to " + widget.planetInfo.name,
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Go To Home",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
                                              (route) => false);
                                    },
                                    color: Color.fromRGBO(0, 179, 134, 1.0),
                                  ),
                                ],
                              ).show();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF00695C),
                                      Color(0xFF80CBC4)
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 250.0, minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  'Upgrade to ' + widget.planetInfo.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
