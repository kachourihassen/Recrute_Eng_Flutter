import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'CvPage.dart';
// import 'details.dart';

class Pdf extends StatefulWidget {
  // final String text;
  // Pdf(this.text);
  @override
  _PdfState createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  PDFDoc _pdfDoc;
  String _text = "";
  bool _buttonsEnabled = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            // iconTheme: IconThemeData(
            //   color: Colors.black, //change your color here
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Upload your CV (PDF Document)'),
          ),
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  label: Text('Upload PDF document'),
                  icon: Icon(Icons.upload_file),
                  onPressed: _pickPDFText,
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  label: Text('Read whole document'),
                  icon: Icon(Icons.read_more),
                  onPressed: _buttonsEnabled ? _readWholeDoc : () {},
                ),
                Padding(
                  child: Text(
                    _pdfDoc == null
                        ? "Pick a new PDF document and wait for it to load..."
                        : "PDF document loaded, ${_pdfDoc.length} pages\n",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(15),
                ),
                Padding(
                  child: Text(
                    _text == "" ? "" : "YOUR PDF:",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(15),
                ),
                Text(_text),
              ],
            ),
          )),
    );
  }

  /// Picks a new PDF document from the device
  Future _pickPDFText() async {
    File file;
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path);
      PlatformFile files = result.files.first;

      print(files.name);
      print(files.bytes);
      print(files.size);
      print(files.extension);
      print(files.path);
      _pdfDoc = await PDFDoc.fromFile(file);
      setState(() {});
    } else {
      // User canceled the picker
    }
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

    String _exp = _exp1.stringMatch(_text).toString();
    String _form = _form1.stringMatch(_text).toString();
    String _comp = _comp1.stringMatch(_text).toString();
    String _logi = _logi1.stringMatch(_text).toString();
    String _email = _email1.stringMatch(_text).toString();
    String _tel = _tel1.stringMatch(_text).toString();
    String _nom = _nom1.stringMatch(_text).toString();
    String _prenom = _prenom1.stringMatch(_text).toString();
    String _post = _post1.stringMatch(_text).toString();
    String _age = _age1.stringMatch(_text).toString();
    String _interet = _interet1.stringMatch(_text).toString();
    String _adress = _adress1.stringMatch(_text).toString();
    //print("split1 : " + _tel1.stringMatch(_text).toString());
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CvPage(_exp, _form, _comp, _logi, _email, _tel,
            _nom, _prenom, _age, _post, _interet, _adress)));
  }

  /// Reads the whole document
  Future _readWholeDoc() async {
    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });

    String text = await _pdfDoc.text;
    //var arr = text.split(" ");

    setState(() {
      _text = text;
      _buttonsEnabled = true;
      _regex();

      // for (var i = 0; i > arr.length - 1; i++) {
      //   //concatenate.write(arr[item]);
      //   print(arr.length);
      //print("begin*******************");
      //print(_text);
      // for (var i = 0; i < arr.length; i++) {
      //   print(arr[i]);
      // }
      // Navigator.of(context).pop();
      // Navigator.of(context)
      //     .push(MaterialPageRoute(builder: (context) => Details(_text)));
    });
  }
}
