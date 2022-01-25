import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionuser/NetworkHandler.dart';
import 'package:gestionuser/Pages/HomePage.dart';
import 'package:gestionuser/Pages/YassinePage/YassinePage.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class CvProffesionnel extends StatefulWidget {
  @override
  _CvProffesionnelState createState() => _CvProffesionnelState();
}

class Company {
  int id;
  String name;
  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Administrateur de base de données'),
      Company(2, 'Administrateur système'),
      Company(3, 'Développeur'),
      Company(4, 'Expert Réseaux'),
    ];
  }
}

class EmployeView {
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
}

class _CvProffesionnelState extends State<CvProffesionnel> {
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController nomController = TextEditingController();

  TextEditingController prenomController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController adresseController = TextEditingController();

  TextEditingController nomdomaineController = TextEditingController();

  TextEditingController datenaissanceController = TextEditingController();

  TextEditingController aptitude1Controller = TextEditingController();

  TextEditingController aptitude2Controller = TextEditingController();

  TextEditingController aptitude3Controller = TextEditingController();

  TextEditingController aptitude4Controller = TextEditingController();

  TextEditingController diplomminController = TextEditingController();

  TextEditingController experienceController = TextEditingController();

  TextEditingController connaissance1Controller = TextEditingController();

  TextEditingController connaissance2Controller = TextEditingController();

  TextEditingController connaissance3Controller = TextEditingController();

  TextEditingController connaissance4Controller = TextEditingController();

  TextEditingController act1Controller = TextEditingController();

  TextEditingController act2Controller = TextEditingController();

  TextEditingController act3Controller = TextEditingController();

  TextEditingController act4Controller = TextEditingController();
  String specialite = "Administrateur de base de données";
  int ver = 0;
  String apt1 = " ",
      apt2 = " ",
      apt3 = " ",
      apt4 = " ",
      dip = " ",
      exp = " ",
      contheo1 = " ",
      contheo2 = " ",
      contheo3 = " ",
      contheo4 = " ",
      act1 = " ",
      act2 = " ",
      act3 = " ",
      act4 = " ";

  List<EmployeView> employes = [];

  List<Company> _companies = Company.getCompanies();

  List<DropdownMenuItem<Company>> _dropdownMenuItems;

  Company _selectedCompany;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropDownItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangedDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false)),
        // title: const Text('My Cv'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset("assets/logo5_5_0242.png",
                  height: 75.0, width: 100.0),
              Center(
                child: Text("Créer un cv professionnel",
                    style: Theme.of(context).textTheme.bodyText1),
              ),
              SizedBox(height: 20.0),
              DropdownButton(
                value: _selectedCompany,
                items: _dropdownMenuItems,
                onChanged: onChangedDropdownItem,
              ),
              SizedBox(height: 10.0),
              OutlineButton(
                  onPressed: () async {
                    print(_selectedCompany.name);
                    specialite = _selectedCompany.name;

                    var response =
                        await networkHandler.get1("/employe/findEmploye");

                    for (var item in response) {
                      if (item["name"] == specialite) {
                        setState(() {
                          apt1 = 'Exemple : ' + item["aptitudes1"];
                          apt2 = 'Exemple : ' + item["aptitudes2"];
                          apt3 = 'Exemple : ' + item["aptitudes3"];
                          apt4 = 'Exemple : ' + item["aptitudes4"];
                          dip = 'Exemple : ' + item["diplomemin"];
                          exp = 'Exemple : ' + item["experiencemin"];
                          contheo1 = 'Exemple : ' + item["connaissancestheo1"];
                          contheo2 = 'Exemple : ' + item["connaissancestheo2"];
                          contheo3 = 'Exemple : ' + item["connaissancestheo3"];
                          contheo4 = 'Exemple : ' + item["connaissancestheo4"];
                          act1 = 'Exemple : ' + item["activitedebase1"];
                          act2 = 'Exemple : ' + item["activitedebase2"];
                          act3 = 'Exemple : ' + item["activitedebase3"];
                          act4 = 'Exemple : ' + item["activitedebase4"];
                        });
                        //print(item["name"]);
                      }
                    }

                    print("Succes Get Specialité exemple");
                  },
                  borderSide: BorderSide(width: 1.0, color: Colors.black87),
                  child: Text('Prendre Des Exemples'),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
              SizedBox(height: 10.0),
              SizedBox(height: 10.0),
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(
                    labelText: 'Nom', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: prenomController,
                decoration: InputDecoration(
                    labelText: 'Prenom', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(
                    labelText: 'Mobile', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: adresseController,
                decoration: InputDecoration(
                    labelText: 'Adresser', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: datenaissanceController,
                decoration: InputDecoration(
                    labelText: 'Date Naissance', border: OutlineInputBorder()),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: aptitude1Controller,
                decoration: InputDecoration(
                    labelText: 'aptitudes', border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$apt1',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: aptitude2Controller,
                decoration: InputDecoration(
                    labelText: 'aptitudes', border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$apt2',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: aptitude3Controller,
                decoration: InputDecoration(
                    labelText: 'aptitudes', border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$apt3',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: aptitude4Controller,
                decoration: InputDecoration(
                    labelText: 'aptitudes', border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$apt4',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: diplomminController,
                decoration: InputDecoration(
                    labelText: 'Diplôme minimum', border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$dip',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: experienceController,
                decoration: InputDecoration(
                    labelText: 'Expérience minimum',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$exp',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: connaissance1Controller,
                decoration: InputDecoration(
                    labelText: 'Connaissances théoriques',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$contheo1',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: connaissance2Controller,
                decoration: InputDecoration(
                    labelText: 'Connaissances théoriques',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$contheo2',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: connaissance3Controller,
                decoration: InputDecoration(
                    labelText: 'Connaissances théoriques',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$contheo3',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: connaissance4Controller,
                decoration: InputDecoration(
                    labelText: 'Connaissances théoriques',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$contheo4',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: act1Controller,
                decoration: InputDecoration(
                    labelText: 'Activités de base',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$act1',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: act2Controller,
                decoration: InputDecoration(
                    labelText: 'Activités de base',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$act2',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: act3Controller,
                decoration: InputDecoration(
                    labelText: 'Activités de base',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$act3',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              TextFormField(
                controller: act4Controller,
                decoration: InputDecoration(
                    labelText: 'Activités de base',
                    border: OutlineInputBorder()),
              ),
              SizedBox(height: 5.0),
              Text(
                '$act4',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 15,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.0),
              FlatButton(
                  onPressed: () async {
                    if (nomController.text.length == 0) {
                      nomController.text = "vide";
                      ver = 1;
                    }

                    if (prenomController.text.length == 0) {
                      prenomController.text = "vide";
                      ver = 1;
                    }

                    if (emailController.text.length == 0) {
                      emailController.text = "vide";
                      ver = 1;
                    }

                    if (mobileController.text.length == 0) {
                      mobileController.text = "vide";
                      ver = 1;
                    }

                    if (adresseController.text.length == 0) {
                      adresseController.text = "vide";
                      ver = 1;
                    }

                    if (datenaissanceController.text.length == 0) {
                      datenaissanceController.text = "vide";
                      ver = 1;
                    }

                    if (aptitude1Controller.text.length == 0) {
                      aptitude1Controller.text = "vide";
                    }

                    if (aptitude2Controller.text.length == 0) {
                      aptitude2Controller.text = "vide";
                    }

                    if (aptitude3Controller.text.length == 0) {
                      aptitude3Controller.text = "vide";
                    }

                    if (aptitude4Controller.text.length == 0) {
                      aptitude4Controller.text = "vide";
                    }

                    if (diplomminController.text.length == 0) {
                      diplomminController.text = "vide";
                    }

                    if (experienceController.text.length == 0) {
                      experienceController.text = "vide";
                    }

                    if (connaissance1Controller.text.length == 0) {
                      connaissance1Controller.text = "vide";
                    }

                    if (connaissance2Controller.text.length == 0) {
                      connaissance2Controller.text = "vide";
                    }

                    if (connaissance3Controller.text.length == 0) {
                      connaissance3Controller.text = "vide";
                    }

                    if (connaissance4Controller.text.length == 0) {
                      connaissance4Controller.text = "vide";
                    }

                    if (act1Controller.text.length == 0) {
                      act1Controller.text = "vide";
                    }

                    if (act2Controller.text.length == 0) {
                      act2Controller.text = "vide";
                    }

                    if (act3Controller.text.length == 0) {
                      act3Controller.text = "vide";
                    }

                    if (act4Controller.text.length == 0) {
                      act4Controller.text = "vide";
                    }
                    if (ver == 1) {
                      /* Alert(
                          context: context,
                          title: "Erreur",
                          content: Column(
                            children: <Widget>[
                              //Text(_quest),
                              Text(
                                "Erreur",
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              //Image.asset("assets/eth.png"),
                              //Text(_reponse),
                              Text(
                                "Verifier Vous Données",
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              //Text(" "),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                "Fermer",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ]).show();*/
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "Erreur",
                        desc: "Verifier Vous Données",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Ok",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Color.fromRGBO(200, 0, 120, 25.0),
                          ),
                        ],
                      ).show();
                    } else {
                      Map<String, dynamic> data = {
                        "username": nomController.text,
                        "lastname": prenomController.text,
                        "email": emailController.text,
                        "mobile": mobileController.text,
                        "adress": adresseController.text,
                        "date": datenaissanceController.text,
                        "name": specialite,
                        "aptitudes1": aptitude1Controller.text,
                        "aptitudes2": aptitude2Controller.text,
                        "aptitudes3": aptitude3Controller.text,
                        "aptitudes4": aptitude4Controller.text,
                        "diplomemin": diplomminController.text,
                        "experiencemin": experienceController.text,
                        "connaissancestheo1": connaissance1Controller.text,
                        "connaissancestheo2": connaissance2Controller.text,
                        "connaissancestheo3": connaissance3Controller.text,
                        "connaissancestheo4": connaissance4Controller.text,
                        "activitedebase1": act1Controller.text,
                        "activitedebase2": act2Controller.text,
                        "activitedebase3": act3Controller.text,
                        "activitedebase4": act4Controller.text
                      };

                      await NetworkHandler().post("/cvprof/ajoutCvprof", data);
                      print("Cv professionnel ajouter");
                      Alert(
                        context: context,
                        type: AlertType.success,
                        title: "Succes",
                        desc: "Cv professionnel ajouter",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Voir Votre Cv",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => YassinePage()),
                                  (route) => false);
                            },
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                          ),
                        ],
                      ).show();
                    }
                  },
                  color: Colors.amber,
                  child: Text('créer'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ],
          )),
        ),
      ),
    );
  }
}
