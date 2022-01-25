import 'package:flutter/material.dart';
import 'package:gestionuser/NetworkHandler.dart';
import 'package:gestionuser/Pages/YassinePage/DetailPage.dart';

class ListEmploye extends StatefulWidget {
  //constructor
  ListEmploye();

  @override
  _ListEmployeState createState() => _ListEmployeState();
}

class _ListEmployeState extends State<ListEmploye> {
  //var
  NetworkHandler networkHandler = NetworkHandler();
  List<EmployeView> employes = [];
  Future<bool> fetchedCar;

  Future<bool> fetchCar() async {
    var response = await networkHandler.get1("/employe/findEmploye");
    for (var item in response) {
      employes.add(EmployeView(
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
          item["activitedebase44"]));
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedCar = fetchCar();
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
      this._activitedebase4);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        //Navigator.pushNamed(context, "/add");
        Navigator.push(context, MaterialPageRoute(
          builder: (BuildContext context) {
            return DetailPage(
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
                this._activitedebase4);
          },
        ));
      },
      child: Card(
        child: Row(
          children: [
            Container(
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    this._name,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15.0),
                  Icon(
                    Icons.navigate_next,
                    color: Colors.black,
                  )
                ],
              ),
              margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
            )
          ],
        ),
      ),
    );
  }
}
