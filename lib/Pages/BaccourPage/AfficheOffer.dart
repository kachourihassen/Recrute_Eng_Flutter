
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionuser/ModelAnnonce/Offer.dart';
import 'package:gestionuser/Pages/BaccourPage/MyText.dart';
import 'package:gestionuser/Pages/BaccourPage/afficheQuiz.dart';

import 'package:http/http.dart' as http;


void main() => runApp(AfficheOffer());

class AfficheOffer extends StatefulWidget {
  @override
  _MyAfficheOffer createState() => _MyAfficheOffer(offer);
  Offer offer;
  AfficheOffer({Key key, @required this.offer}) : super(key: key);
}

class _MyAfficheOffer extends State<AfficheOffer>  {
  Offer offer;
  _MyAfficheOffer(Offer o)
  {
    this.offer=o;
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  void initState() {

    super.initState();
  }
  //var


  final _scaffoldkey=GlobalKey<ScaffoldState>();
  int _counter=120;
  TextEditingController TitreC= TextEditingController();
  TextEditingController MyController= TextEditingController();
  TextEditingController expC= TextEditingController();
  TextEditingController descC= TextEditingController();
  TextEditingController entrC= TextEditingController();
  TextEditingController sexeC= TextEditingController();
  TextEditingController contrC= TextEditingController();
  TextEditingController postC= TextEditingController();
  TextEditingController adrC= TextEditingController();
  TextEditingController salC= TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    TitreC.text=offer.nomentr;
    MyController.text=offer.skills;
    expC.text=offer.anexp;
    descC.text=offer.descpost ;
    entrC.text= offer.descentr;
    sexeC.text= offer.sexe;
    contrC.text= offer.typecont;
    postC.text=offer.post ;
    adrC.text=offer.adress ;
    salC.text=offer.salaire ;

    return Scaffold(
      appBar: AppBar(
        title:  Text(offer.nomentr),

      ),
      body:


      ListView(
          children:[
            /* Text('Titre'
                ),
                MyText(
                  hintText: 'Titre',
                  enable: false,
                  Controller: TitreC,
                ),*/
            Text('Skills'
            ),
            MyText(
              enable: false,
              Controller: MyController,
            ),
            Text('Experience'
            ),
            MyText(
              hintText: 'Experience',
              enable: false,
              Controller:expC,
            ),

            Text('Descrepsion'
            ),
            MyText(
              hintText: 'Descrepsion',
              linesize: 5,
              enable: false,
              Controller:descC,
            ),
            Text('Entreprise'
            ),
            MyText(
              hintText: 'Entreprise',
              enable: false,
              Controller:entrC,
            ),
            Text('Sexe'
            ),
            MyText(
              hintText: 'Sexe',
              enable: false,
              Controller: sexeC,
            ),
            Text('Type contrat'
            ),
            MyText(
                hintText: 'Type contrat',
                enable: false,
                Controller:contrC
            ),

            Text('Post'
            ),
            MyText(
              hintText: 'Post',
              enable: false,
              Controller:postC,
            ),
            Text('Adresse'
            ),
            MyText(
              hintText: 'Adresse',
              enable: false,
              Controller:adrC,
            ),
            Text('Salaire'
            ),
            MyText(
              hintText: 'Salaire',
              enable: false,
              Controller:salC,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child:   RaisedButton(
                    child: Text("Submit Quiz"),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AfficheQuiz(nom: offer.nomentr)),
                      );
                    }
                )),
            SizedBox(
              height: 70,
            )
          ] ),

    );


  }


}