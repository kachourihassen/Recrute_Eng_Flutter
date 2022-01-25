import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:gestionuser/AI/CvPage.dart';

class Details extends StatefulWidget {
  final String text;
  Details(this.text);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Details of your scanne'),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              FlutterClipboard.copy(widget.text).then((value) => _key
                  .currentState
                  .showSnackBar(new SnackBar(content: Text('Copied'))));
              log(" " + (widget.text));
            },
          ),
          IconButton(
            icon: Icon(Icons.all_inclusive),
            onPressed: () {
              _regex();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        alignment: Alignment.center,
        height: double.infinity,
        width: double.infinity,
        child: SelectableText(
            widget.text.isEmpty ? 'No Text Available' : widget.text),
      ),
    );
  }

  Future<dynamic> _regex() async {
    RegExp _exp1 = new RegExp(
        r"((?<=EXPÉRIENCE PROFESSIONNELLE)|(?<=EXPERIENCES PROFESSIONNELLES))(\n.+)*?((?=\s+COMPÉTENCES)|(?=\s+FORMATION)|(?=\s+LOGICIELS)|(?=\s+QUALIFICATIONS ET COMPETENCES)|(?=\s+FORMATION ET DIPLOMES)|(?=\s+FORMATION ET DIPLOMES))",
        caseSensitive: false);
    RegExp _form1 = new RegExp(
        r"((?<=FORMATION)|(?<=FORMATION ET DIPLOMES))(\n.+)*?((?=\s+COMPÉTENCES)|(?=\s+EXPÉRIENCE PROFESSIONNELLE)|(?=\s+LOGICIELS)|(?=\s+LANGUES)|(?=\s+QUALIFICATIONS ET COMPETENCES)|(?=\s+EXPERIENCES PROFESSIONNELLES)|(?=\s+CENTRES D’INTERET ET QUALITES PERSONNELLES)|.)",
        caseSensitive: false);
    RegExp _comp1 = new RegExp(
        r"((?<=COMPÉTENCES)|(?<=QUALIFICATIONS ET COMPETENCES))(\n.+)*?((?=\s+FORMATION)|(?=\s+EXPÉRIENCE PROFESSIONNELLE)|(?=\s+LOGICIELS)|(?=\s+LANGUES)|(?=\s+FORMATION ET DIPLOMES)|(?=\s+EXPERIENCES PROFESSIONNELLES)|.)",
        caseSensitive: false);
    RegExp _logi1 = new RegExp(
        r"(?<=LOGICIELS)(\n.+)*?((?=\s+COMPÉTENCES)|(?=\s+EXPÉRIENCE PROFESSIONNELLE)|(?=\s+FORMATION)|(?=\s+LANGUES)|(?=\s+QUALIFICATIONS ET COMPETENCES)|(?=\s+FORMATION ET DIPLOMES))",
        caseSensitive: false);
    RegExp _email1 = new RegExp(
        r"\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b",
        caseSensitive: false);
    RegExp _nom1 = new RegExp(
        r"((?<=Nom)|(?<=NOM)).*[A-Z][a-z].*(-[A-Z][a-z]?)?",
        caseSensitive: false);
    RegExp _prenom1 = new RegExp(
        r"((?<=Prenom)|(?<=Prénom)).*[A-Z][a-z].*(-[A-Z][a-z]?)?",
        caseSensitive: false);
    RegExp _age1 = new RegExp(r"(?<=Age).*( [1-9][1-9])", caseSensitive: false);
    RegExp _post1 = new RegExp(
        r"((?<=POSTE  )| (?<=POSTE OCCUPÉ/ )).*( [A-z]|[A-Z]).*",
        caseSensitive: false);
    RegExp _interet1 = new RegExp(
        r"(?<=CENTRES D’INTERET ET QUALITES PERSONNELLES)(\n.+)*?((?=\s+COMPÉTENCES)|(?=\s+FORMATION)|(?=\s+LOGICIELS)|(?=\s+QUALIFICATIONS ET COMPETENCES)|(?=\s+FORMATION ET DIPLOMES)|(?=\s+FORMATION ET DIPLOMES)|.)",
        caseSensitive: false);
    RegExp _tel1 = new RegExp(r"(\d{2}\s\d{2}\s\d{2}\s\d{2}\s\d{2}\s)",
        caseSensitive: false);
    RegExp _adress1 = new RegExp(
        r"((?<=Adresse)|(?<=ADRESSE)).*( [A-z]|[A-Z]).*",
        caseSensitive: false);

    String _exp = _exp1.stringMatch(widget.text).toString();
    String _form = _form1.stringMatch(widget.text).toString();
    String _comp = _comp1.stringMatch(widget.text).toString();
    String _logi = _logi1.stringMatch(widget.text).toString();
    String _email = _email1.stringMatch(widget.text).toString();
    String _tel = _tel1.stringMatch(widget.text).toString();
    String _nom = _nom1.stringMatch(widget.text).toString();
    String _prenom = _prenom1.stringMatch(widget.text).toString();
    String _post = _post1.stringMatch(widget.text).toString();
    String _age = _age1.stringMatch(widget.text).toString();
    String _interet = _interet1.stringMatch(widget.text).toString();
    String _adress = _adress1.stringMatch(widget.text).toString();
    //print("split1 : " + _tel1.stringMatch(_text).toString());
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CvPage(_exp, _form, _comp, _logi, _email, _tel,
            _nom, _prenom, _age, _post, _interet, _adress)));
  }
}
