import 'dart:convert';



import 'package:flutter/material.dart';
import 'package:gestionuser/ModelAnnonce/Offer.dart';
import 'package:gestionuser/NetworkHandler.dart';
import 'package:gestionuser/Pages/BaccourPage/ConfirmeQcm.dart';
import 'package:gestionuser/Pages/BaccourPage/MyText.dart';
import 'package:http/http.dart' as http;
import 'package:numberpicker/numberpicker.dart';

class Ajout_Offer_Form extends StatefulWidget {
  static Offer model = Offer();

  @override
  _Ajout_Offer_Form createState() => _Ajout_Offer_Form();
}

class _Ajout_Offer_Form extends State<Ajout_Offer_Form> {




  @override
  void initState() {
    super.initState();
    Ajout_Offer_Form.model.sexe="homme";
  }
  //var

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Creé Offer'),

            ),
            body:
            TestForm()

        ));


  }


}
class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {

  final _formKey = GlobalKey<FormState>();

  int _currentValue=0;
  List <String> ChoixList=["java","ajax","html","dart","php"];
  List <String> skil=[];
  String newstring;
  String skilstring="";
  final testKey = Key('sk');
  String radio="homme";

  List<String> _locations = ["java","ajax","html","dart","php"]; // Option 2
  String _selectedLocation;
  TextEditingController MyController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;



    return
      ListView(
          children:<Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  MyText(
                    hintText: 'Titre',

                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Saisie le titre';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      Ajout_Offer_Form.model.nomentr = value;
                    },
                  ),
                  DropdownButton(
                    hint: Text('Skills'), // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {

                      setState(() {
                        _selectedLocation = newValue;
                        skil.add(newValue);
                        //Ajout_Offer_Form.model.skill = skil;
                        skilstring="";
                        for(int i =0; i<=skil.length-1;i++)
                          skilstring=skilstring+" "+skil[i];
                        MyController.text=skilstring;
                      });
                      Ajout_Offer_Form.model.skills=skilstring;
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                  TextField(
                    enabled: false,
                    controller: MyController,
                  ),
                  /* MyText(
            hintText: 'Skills',

            validator: (String value) {
              if (value.isEmpty) {
                return 'Saisie les Skills';
              }
              return null;
            },
            onSaved: (String value1) {
              Ajout_Offer_Form.model.skill = value1;
            },
            onChanged: (String value1){
              skil=value1.split(" ");
              print(skil[skil.length-1]);
              for(String i in ChoixList)
                {
                  if(skil[skil.length-1].length>1){
                    if(i.startsWith(skil[skil.length-1]))
                    {
                      newstring=i;
                      MyController.value=TextEditingValue(text: newstring);
                      //setState(() {value=i;});

                      value1=i;
                      print(value1);}
                  }
                }

            },
            //

          ),*/
                  Text('Experience'),
                  NumberPicker(
                    value: _currentValue,
                    axis: Axis.horizontal,
                    minValue: 0,
                    maxValue: 10,

                    onChanged: (value) => setState(() => {Ajout_Offer_Form.model.anexp = value.toString(),_currentValue=value,MyController.text=newstring}),
                  ),


                  MyText(
                    hintText: 'Descrepsion',
                    linesize: 5,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Saisie le Descreption';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      Ajout_Offer_Form.model.descpost = value;
                    },
                  ),
                  /*   MyText(
            hintText: 'entreprise',
            validator: (String value) {
              if (value.isEmpty) {
                return 'Saisie le entreprise';
              }
              return null;
            },
            onSaved: (String value) {
              Ajout_Offer_Form.model.descentr = value;
            },
          ),*/
                  MyText(
                    hintText: 'Type contrat',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Saisie le Type contrat';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      Ajout_Offer_Form.model.typecont = value;
                    },
                  ),
                  ListTile(
                    title: const Text('Homme'),
                    leading: Radio(
                      value: "homme",
                      groupValue: radio,
                      onChanged: (String value) {
                        setState(() {
                          radio= value;
                          Ajout_Offer_Form.model.sexe = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Femme'),
                    leading: Radio(
                      value: "femme",
                      groupValue: radio,
                      onChanged: (String value) {
                        setState(() {
                          radio= value;
                          Ajout_Offer_Form.model.sexe = value;
                        });
                      },
                    ),
                  ),

                  MyText(
                    hintText: 'Post',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Saisie le Post';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      Ajout_Offer_Form.model.post = value;
                    },
                  ),
                  /* MyText(
            hintText: 'Adresse',
            validator: (String value) {
              if (value.isEmpty) {
                return 'Saisie le Adresse';
              }
              return null;
            },
            onSaved: (String value) {
              Ajout_Offer_Form.model.adresse = value;
            },
          ),*/
                  MyText(
                    hintText: 'Salaire',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Saisie le Salaire';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      Ajout_Offer_Form.model.salaire = value;
                    },
                  ),

                  RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        saveOffer(Ajout_Offer_Form.model);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Ajout_Qcm_Form()),
                        );
                        // Navigator.push(
                        //   context,
                        //  MaterialPageRoute(
                        //      builder: (context) => Result(model: this.model)));
                      }
                    },
                    child: Text(
                      'enregistrer',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          ]
      );
  }
  void saveOffer(Offer q) async {
    print("dfv");
    final response = await http.post(
      "http://192.168.1.3:5000/annonce/addannonce1",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "user": "majdi",
        "nomentr": q.nomentr,
        "skills": q.skills,
        "anexp": q.anexp,
        "descpost": q.descpost,
        'poste': q.post,
        'descentr': "yassine",
        'typecont': q.typecont,
        'sexe': q.sexe,
        'adress': "q.adresse",
        'salaire': q.salaire,

      }),
    );

    if (response.statusCode == 200) {
      print(q.user);

    } else {
      print(response.body);
      throw Exception(response.statusCode);

    }
  }
}