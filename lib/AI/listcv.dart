import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestionuser/ModelAnnonce1/Offer.dart';
import 'package:gestionuser/ModelCv/cvModel.dart';

import 'package:gestionuser/Pages/HomePage.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:intl/intl.dart';

import 'package:string_similarity/string_similarity.dart';
import 'package:http/http.dart' as http;
import '../NetworkHandler.dart';
import 'CvPageUpdate.dart';
import 'grouplist.dart';

final networkHandler = NetworkHandler();

class Listcv extends StatefulWidget {
  @override
  _ListcvState createState() => _ListcvState();
}

class _ListcvState extends State<Listcv> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  CvModel cvModel = CvModel();

  var fList;
  List<Offer> offerList = [];

  List<dynamic> caches;
  String id = "";
  String tot = "";
  String a = "";
  String b = "";
  String c = "";
  List<String> listtitre = [] ?? null;
  List<String> listeexp = [] ?? null;
  List<String> listeskill = [] ?? null;
  Offer offreModel = Offer();

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/cv/getDatacv");

    setState(() {
      cvModel = CvModel.fromJson(response["data"]);

      circular = false;
    });
  }

  Future<List<Offer>> getOffer() async {
    final urlList = ["http://192.168.152.157:5000/offer/findoffer"];
    final responses = await Future.wait(
      urlList.map((String url) {
        return http.get(url);
      }),
    );

    caches = responses.map((response) {
      return (json.decode(response.body) as List)
          .map((data) => Offer.fromJson(data))
          .toList();
    }).toList();

    fList = List<Offer>.from(caches[0]);

    Offer offer = new Offer();
    for (Offer q in fList) {
      offer.titre = q.titre;
      offer.user = q.user;
      offer.description = q.description;
      offer.skill = q.skill;
      offer.post = q.post;
      offer.descentr = q.descentr;
      offer.typecont = q.typecont;
      offer.sexe = q.sexe;
      offer.adresse = q.adresse;
      offer.salaire = q.salaire;
    }

    return fList;
  }

  yourFunction() async {
    offerList = await getOffer();

    int x = offerList.length;
    for (var i = 0; i < x; i++) {
      final comparison =
          cvModel.title.toString().similarityTo(offerList[i].post.toString());
      final comparison1 =
          cvModel.skills.toString().similarityTo(offerList[i].skill.toString());

      RegExp _year1 = new RegExp(r'((\s|T)\d{4})', caseSensitive: false);
      String _exp =
          _year1.stringMatch(cvModel.experience.toString()).toString();
      int one = int.parse(_exp);

      int two = int.parse(offerList[i].experience.toString());

      String date = DateFormat.y().format(DateTime.now());
      int date1 = int.parse(date);

      int s = max(one, date1) - min(one, date1);
      double total = 0.0;
      if (s >= two) {
        final comparison2 = 1.0;
        total = (((comparison2 + comparison1 + comparison) * 100) / 3);
      } else {
        final comparison2 = 0.0;
        total = (((comparison2 + comparison1 + comparison) * 100) / 3);
      }
      if (total > 20.0) {
        id += " " + (offerList[i].id.toString());
        int o = total.round();
        tot += " " + o.toString();
      }
    }
    for (var i = 1; i <= id.split(" ").length - 1; i++) {
      var response = await networkHandler.get("/offer/id/" + id.split(" ")[i]);
      offreModel = Offer.fromJson(response["data"]);

      setState(() {
        a += "*" + offreModel.titre;
        b += "*" + offreModel.experience;
        c += "*" + offreModel.skill;
      });
    }
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AwesomeApp(id, tot, a, b, c)));
  }

  @override
  Widget build(BuildContext context) {
    String a = cvModel.username.toString();
    String b = cvModel.lastname.toString();
    String c = cvModel.title.toString();
    String d = cvModel.email.toString();
    String e = cvModel.mobile.toString();
    String f = cvModel.adress.toString();
    String g = cvModel.date.toString();
    String aa = cvModel.about.toString();
    String bb = cvModel.education.toString();
    String cc = cvModel.skills.toString();
    String dd = cvModel.experience.toString();
    String ee = cvModel.intere.toString();
    String ff = cvModel.reference.toString();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false)),
          title: const Text('My Cv'),
        ),
        body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                height: size.height,
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/a.jpg",
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (BuildContext ctx, index) {
                            return SwipeActionCell(
                              index: index,
                              key: ValueKey(1),
                              performsFirstActionWithFullSwipe: true,
                              trailingActions: [
                                SwipeAction(
                                    title: "Update",
                                    nestedAction:
                                        SwipeNestedAction(title: "confirm"),
                                    onTap: (_) async {
                                      //list.removeAt(index);
                                      setState(() {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => CvPageUp(
                                              a,
                                              b,
                                              c,
                                              d,
                                              e,
                                              f,
                                              g,
                                              aa,
                                              bb,
                                              cc,
                                              dd,
                                              ee,
                                              ff),
                                        ));
                                      });
                                    }),
                                // SwipeAction(
                                //     title: "action2",
                                //     color: Colors.grey,
                                //     onTap: (handler) {}),
                              ],
                              leadingActions: [
                                // SwipeAction(
                                //     title: "delete",
                                //     onTap: (handler) async {
                                //       await handler(true);
                                //       //list.removeAt(index);
                                //       setState(() {});
                                //     }),
                                SwipeAction(
                                    title: "Search",
                                    //color: Colors.orange,

                                    color: Colors.indigo,
                                    onTap: (_) async {
                                      setState(() {
                                        yourFunction();
                                      });
                                    }),
                              ],
                              child: Card(
                                color: index % 2 == 0
                                    ? Colors.cyan[50]
                                    : Colors.deepOrange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      40), // if you need this
                                  side: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 50),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text('Cv'),
                                  ),
                                  title: Text(
                                    "Title" +
                                        ":" +
                                        "\n" +
                                        (c = cvModel.title.toString() != null
                                            ? '$c '
                                            : "Empty") +
                                        "\n" +
                                        "\n" +
                                        "First Name" +
                                        ":" +
                                        "\n" +
                                        (a = cvModel.username.toString() != null
                                            ? '$a'
                                            : "Empty") +
                                        "\n"
                                            "\n" +
                                        "Last Name" +
                                        ":" +
                                        "\n" +
                                        (b = cvModel.lastname.toString() != null
                                            ? '$b'
                                            : "Empty") +
                                        "\n",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "Email" +
                                        ":" +
                                        "\n" +
                                        (d = cvModel.email.toString() != null
                                            ? '$d'
                                            : "Empty") +
                                        "\n" +
                                        "\n"
                                            "Adress" +
                                        ":" +
                                        "\n" +
                                        (f = cvModel.adress.toString() != null
                                            ? '$f '
                                            : "Empty") +
                                        "\n"
                                            "\n" +
                                        "Age" +
                                        ":" +
                                        "\n" +
                                        (g = cvModel.date.toString() != null
                                            ? '$g'
                                            : "Empty") +
                                        "\n"
                                            "\n"
                                            "\n",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Icon(Icons.swipe),
                                  onTap: () {},
                                  enabled: false,
                                ),
                              ),
                            );
                          }))
                ]))));
  }
}
