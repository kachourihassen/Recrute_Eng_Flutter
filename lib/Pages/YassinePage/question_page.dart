import 'package:flutter/material.dart';
import 'package:gestionuser/NetworkHandler.dart';

import 'package:rflutter_alert/rflutter_alert.dart';

class QuestionPage extends StatefulWidget {
  //constructor
  QuestionPage();

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  //var
  //return Scaffold(

  NetworkHandler networkHandler = NetworkHandler();
  List<QuestionView> questionlist = [];
  Future<bool> fetchedMes;

  Future<bool> fetchMes() async {
    var response = await networkHandler.get1("/question/findQuestion");
    for (var item in response) {
      questionlist
          .add(QuestionView(item["numquestion"], item["quest"], item["repon"]));
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    fetchedMes = fetchMes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedMes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return questionlist[index];
            },
            itemCount: questionlist.length,
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

class QuestionView extends StatelessWidget {
  //var
  String _numquestion;
  String _quest;
  String _reponse;

  //String _description;
  //int _quantity;

  QuestionView(
      this._numquestion,
      this._quest,
      this._reponse,
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*Alert(
            context: context,
            title: " ",
            content: Column(
              children: <Widget>[
                //Text(_quest),

                //Image.asset("assets/eth.png"),
                //Text(_reponse),
                Text(
                  _reponse,
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
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();*/

        Alert(
          context: context,
          type: AlertType.info,
          title: "Reponse",
          desc: _reponse,
          buttons: [
            DialogButton(
              child: Text(
                "ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ]),
            )
          ],
        ).show();
      },
      child: Row(
        children: [
          SizedBox(width: 5),
          Container(
            width: 380,
            height: 120,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey[200], Colors.blue[100]],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                border: Border.all(
                  width: 5,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(18)

              // Make rounded corners
            ),
            child: Column(
              children: [
                Text(
                  this._quest,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.menu_book_rounded,
                  color: Colors.black,
                ),
                Text("  "),
                Text(
                  "                                                                               Voir la reponse",
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          )
        ],
      ),
    );
  }
}