import 'package:flutter/material.dart';
import 'package:gestionuser/NetworkHandler.dart';

class ListCvprof extends StatefulWidget {
  //constructor
  ListCvprof();

  @override
  _ListCvprofState createState() => _ListCvprofState();
}

class _ListCvprofState extends State<ListCvprof> {
  String username = "username", s = "s";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedCar = fetchCar();
  }

  void checkuser() async {
    var response1 = await networkHandler.get("/user/" + username.toString());
    Map<String, dynamic> v = response1["data"];
    print(v["email"]);
    s = v["username"];
    print("3333" + s);
  }

  //var
  NetworkHandler networkHandler = NetworkHandler();
  List<EmployeView> employes = [];
  Future<bool> fetchedCar;

  Future<bool> fetchCar() async {
    String f;
    var response3 = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response3['username'];
    });
    if (response3["status"] == true) {
      setState(() {});
    } else {
      setState(() {});
    }
    checkuser();
    f = username;
    print(username + "10245693232");
    var response = await networkHandler.get1("/cvprof/findCvprof");
    for (var item in response) {
      print(f);
      print(item["username"]);
      if (item["username"] == f) {
        employes.add(EmployeView(
            item["username"],
            item["lastname"],
            item["email"],
            item["mobile"],
            item["adress"],
            item["date"],
            item["name"],
            item["aptitudes1"],
            item["aptitudes2"],
            item["aptitudes3"],
            item["aptitudes4"],
            item["diplomemin"],
            item["experiencemin"],
            item["connaissancestheo1"],
            item["connaissancestheo2"],
            item["connaissancestheo3"],
            item["connaissancestheo4"],
            item["activitedebase1"],
            item["activitedebase2"],
            item["activitedebase3"],
            item["activitedebase4"]));
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: fetchedCar,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return employes[index];
            },
            itemCount: employes.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class EmployeView extends StatelessWidget {
  //var
  String _username;
  String _lastname;
  String _email;
  String _mobile;
  String _adress;
  String _date;
  String _name;
  String _aptitudes1;
  String _aptitudes2;
  String _aptitudes3;
  String _aptitudes4;
  String _diplomemin;
  String _experiencemin;
  String _connaissancestheo1;
  String _connaissancestheo2;
  String _connaissancestheo3;
  String _connaissancestheo4;
  String _activitedebase1;
  String _activitedebase2;
  String _activitedebase3;
  String _activitedebase4;
  //String _description;
  //int _quantity;

  EmployeView(
      this._username,
      this._lastname,
      this._email,
      this._mobile,
      this._adress,
      this._date,
      this._name,
      this._aptitudes1,
      this._aptitudes2,
      this._aptitudes3,
      this._aptitudes4,
      this._diplomemin,
      this._experiencemin,
      this._connaissancestheo1,
      this._connaissancestheo2,
      this._connaissancestheo3,
      this._connaissancestheo4,
      this._activitedebase1,
      this._activitedebase2,
      this._activitedebase3,
      this._activitedebase4,
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
        onTap: () {
      //Navigator.pushNamed(context, "/add");
      //("hne navigation")
    },
    child: Row(
    children: [
    SizedBox(width: 5),
    Container(
    width: 380,
    height: 1000,
    decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [Colors.grey[200], Colors.blue[100]],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    ),
    border: Border.all(
    width: 5,
    color: Colors.grey[200],
    ),
    borderRadius: BorderRadius.circular(18)

    // Make rounded corners
    ),
    child: Column(
    children: [
    SizedBox(height: 22),
    Text(
    this._name,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 22,
    color: Colors.blue,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(height: 22),
    Row(
    children: <Widget>[
    Text(
    '   Nom et Prénom : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(width: 10),
    Text(
    this._username + " " + this._lastname,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    ],
    ),
    SizedBox(height: 4),
    Row(
    children: <Widget>[
    Text(
    '   Email : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(width: 10),
    Text(
    this._email,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    ],
    ),
    SizedBox(height: 4),
    Row(
    children: <Widget>[
    Text(
    '   Mobile : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(width: 10),
    Text(
    this._mobile,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    ],
    ),
    SizedBox(height: 4),
    Row(
    children: <Widget>[
    Text(
    '   Adresse : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(width: 10),
    Text(
    this._adress,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    ],
    ),
    SizedBox(height: 4),
    Row(
    children: <Widget>[
    Text(
    '   Date de Naissance : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(width: 10),
    Text(
    this._date,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    ],
    ),
    Text(
    "  ",
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    Row(
    children: <Widget>[
    Text(
    '   Aptitudes : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    ],
    ),
    SizedBox(height: 15),
    Text(
    "-" + this._aptitudes1,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._aptitudes2,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._aptitudes3,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._aptitudes4,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(" "),
    Row(
    children: <Widget>[
    Text(
    'Connaissance Théorique : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(width: 10),
    ],
    ),
    SizedBox(height: 15),
    Text(
    "-" + this._connaissancestheo1,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._connaissancestheo2,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._connaissancestheo3,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._connaissancestheo4,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(" "),
    Row(
    children: <Widget>[
    Text(
    'Activité de Base : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(width: 10),
    ],
    ),
    SizedBox(height: 15),
    Text(
    "-" + this._activitedebase1,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._activitedebase2,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._activitedebase3,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
    "-" + this._activitedebase4,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text("  "),
    Row(
    children: <Widget>[
    Text(
    'Experience : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.left,
    ),
    SizedBox(width: 10),
    ],
    ),
    Text(
    this._experiencemin,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 15),
    Row(
    children: <Widget>[
    Text(
    'Diplome : ',
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.start,
    ),
    SizedBox(width: 10),
    ],
    ),
    Text(
    this._diplomemin,
    style: TextStyle(
    fontFamily: 'Avenir',
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w900,
    ),
    textAlign: TextAlign.start,
    ),
    ],
    ),
    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
    )
    ],
    ),
    );
  }
}