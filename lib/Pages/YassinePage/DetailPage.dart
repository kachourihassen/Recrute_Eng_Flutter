import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
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

//constructor
  DetailPage(
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
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String bbb;
  List<ExpansionItem> items = <ExpansionItem>[
    ExpansionItem(header: "Activité de base", body: "act1"),
    ExpansionItem(header: "Connaissances théoriques", body: "con1"),
    ExpansionItem(header: "Aptitudes", body: "apt1"),
    ExpansionItem(header: "Expreince minimum", body: "exp1"),
    ExpansionItem(header: "Déplome minimum", body: "dip1"),
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(this.widget._name),
        ),
        body: ListView(
          children: [
            ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[index].isExpanded = !items[index].isExpanded;
                });
              },
              children: items.map((ExpansionItem item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.white,
                      width: 48.0,
                      height: 48.0,
                      child: Center(
                        child: Text(
                          item.header,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                  isExpanded: item.isExpanded,
                  body: Column(
                    children: [
                      if (item.header == "Activité de base") ...[
                        Text(
                          this.widget._activitedebase1,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(" "),
                        Text(
                          this.widget._activitedebase2,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(" "),
                        Text(
                          this.widget._activitedebase3,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.0),
                      ] else if (item.header == "Connaissances théoriques") ...[
                        Text(
                          this.widget._connaissancestheo1,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(" "),
                        Text(
                          this.widget._connaissancestheo2,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(" "),
                        Text(
                          this.widget._connaissancestheo3,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(" "),
                        Text(
                          this.widget._connaissancestheo4,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.0),
                      ] else if (item.header == "Aptitudes") ...[
                        Text(
                          this.widget._aptitudes1,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(" "),
                        Text(
                          this.widget._aptitudes2,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(" "),
                        Text(
                          this.widget._aptitudes3,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(" "),
                        Text(
                          this.widget._aptitudes4,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.0),
                      ] else if (item.header == "Expreince minimum") ...[
                        Text(
                          this.widget._experiencemin,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.0),
                      ] else if (item.header == "Déplome minimum") ...[
                        Text(
                          this.widget._diplomemin,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.0),
                      ]
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ));
  }
}

class ExpansionItem {
  bool isExpanded;
  final String header;
  final body;
  ExpansionItem({this.isExpanded: false, this.header, this.body});
}
