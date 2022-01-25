import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gestionuser/Pages/HomePage.dart';
import 'package:image_picker/image_picker.dart';

import '../NetworkHandler.dart';
import 'listcv.dart';

class CvPageUp extends StatefulWidget {
  final String prenom;
  final String nom;
  final String titre;
  final String email;
  final String tel;
  final String adress;
  final String age;
  final String about;
  final String education;
  final String skills;
  final String exp;
  final String intere;
  final String ref;
  CvPageUp(
      this.prenom,
      this.nom,
      this.titre,
      this.email,
      this.tel,
      this.adress,
      this.age,
      this.about,
      this.education,
      this.skills,
      this.exp,
      this.intere,
      this.ref);
  @override
  MapScreenupState createState() => MapScreenupState();
}

class MapScreenupState extends State<CvPageUp>
    with SingleTickerProviderStateMixin {
  TextEditingController _a = TextEditingController();
  TextEditingController _b = TextEditingController();
  TextEditingController _c = TextEditingController();
  TextEditingController _d = TextEditingController();
  TextEditingController _e = TextEditingController();
  TextEditingController _f = TextEditingController();
  TextEditingController _g = TextEditingController();
  TextEditingController _h = TextEditingController();
  TextEditingController _i = TextEditingController();
  TextEditingController _j = TextEditingController();
  TextEditingController _k = TextEditingController();
  TextEditingController _l = TextEditingController();
  TextEditingController _m = TextEditingController();

  bool _status = true;
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  final FocusNode myFocusNode = FocusNode();
  final _globalkey = GlobalKey<FormState>();
  bool circular = false;
  final networkHandler = NetworkHandler();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            color: Colors.white,
            child: Form(
              key: _globalkey,
              child: new ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new Container(
                        height: 250.0,
                        color: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left: 20.0, top: 20.0),
                                child: new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new IconButton(
                                        icon: Icon(Icons.arrow_back_sharp),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => HomePage()),
                                          );
                                        }),

                                    //   Icons.arrow_back_ios,
                                    //   color: Colors.black,
                                    //   size: 22.0,

                                    // ),

                                    Padding(
                                      padding: EdgeInsets.only(left: 25.0),
                                      child: new Text(
                                          'Update My Curriculum Vitae',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              fontFamily: 'sans-serif-light',
                                              color: Colors.black)),
                                    )
                                  ],
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: new Stack(
                                  fit: StackFit.loose,
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[imageProfile()],
                                    ),
                                  ]),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        color: Color(0xffFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Parsonal Information',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          _status
                                              ? _getEditIcon()
                                              : new Container(),
                                        ],
                                      )
                                    ],
                                  )),
                              Padding(
                                  //1
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'FirstName',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //1
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            controller: _a =
                                                TextEditingController(
                                                    text: widget.prenom),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your FirstName",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  //2
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'LastName',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //2
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            controller: _b =
                                                TextEditingController(
                                                    text: widget.nom),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your LastName",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  //3
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Title',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //3
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            controller: _c =
                                                TextEditingController(
                                                    text: widget.titre),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your Title",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Email ID',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            autofocus: false,
                                            controller: _d =
                                                TextEditingController(
                                                    text: widget.email),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                                hintText: "Enter Email ID",
                                                hintStyle: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.redAccent)),
                                            enabled: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Mobile',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            autofocus: false,
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            controller: _e =
                                                TextEditingController(
                                                    text: widget.tel),
                                            decoration: const InputDecoration(
                                                hintText: "Enter Mobile Number",
                                                hintStyle: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.redAccent)),
                                            enabled: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'Adress',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: new Text(
                                            'Age',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Material(
                                              elevation: 20.0,
                                              shadowColor: Colors.black12,
                                              child: new TextFormField(
                                                controller: _f =
                                                    TextEditingController(
                                                        text: widget.adress),
                                                validator: (value) {
                                                  if (value.isEmpty)
                                                    return "Name can't be empty";

                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Enter Adress",
                                                        hintStyle: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors
                                                                .redAccent)),
                                                enabled: !_status,
                                              ),
                                            )),
                                        flex: 2,
                                      ),
                                      Flexible(
                                        child: Material(
                                            elevation: 20.0,
                                            shadowColor: Colors.black12,
                                            child: new TextFormField(
                                              controller: _g =
                                                  TextEditingController(
                                                      text: widget.age),
                                              validator: (value) {
                                                if (value.isEmpty)
                                                  return "Name can't be empty";

                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  hintText: "Enter Age",
                                                  hintStyle: TextStyle(
                                                      fontSize: 15.0,
                                                      color: Colors.redAccent)),
                                              enabled: !_status,
                                            )),
                                        flex: 2,
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //4
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'About Me',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //4
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            controller: _h =
                                                TextEditingController(
                                                    text: widget.about),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            maxLines: 6,
                                            decoration: const InputDecoration(
                                              hintText:
                                                  "Description about your self",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  //5
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Education',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //5
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            controller: _i =
                                                TextEditingController(
                                                    text: widget.education),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            maxLines: 6,
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your Education",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  //6
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Skills',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //6
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            controller: _j =
                                                TextEditingController(
                                                    text: widget.skills),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            maxLines: 6,
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your Skills",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  //9
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Experience',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //9
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            //controller: _name,
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            controller: _k =
                                                TextEditingController(
                                                    text: widget.exp),
                                            maxLines: 6,
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your Experience",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  //10
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Hobbies and Interests',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //10
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            controller: _l =
                                                TextEditingController(
                                                    text: widget.intere),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            maxLines: 6,
                                            decoration: const InputDecoration(
                                              hintText:
                                                  "Enter Your Hobbies and Interests",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              Padding(
                                  //11
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 25.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          new Text(
                                            'Reference',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Padding(
                                  //11
                                  padding: EdgeInsets.only(
                                      left: 25.0, right: 25.0, top: 2.0),
                                  child: new Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      new Flexible(
                                        child: Material(
                                          elevation: 20.0,
                                          shadowColor: Colors.black12,
                                          child: new TextFormField(
                                            controller: _m =
                                                TextEditingController(
                                                    text: widget.ref),
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "Name can't be empty";

                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: "Enter Your Reference",
                                              hintStyle: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent),
                                            ),
                                            enabled: !_status,
                                            autofocus: !_status,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              !_status ? _getActionButtons() : new Container(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the Widget is disposed
  //   myFocusNode.dispose();
  //   super.dispose();
  // }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/images/3125988.jpg")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.red,
              size: 35.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  insertcv();
                  // setState(() {
                  //   _status = true;
                  //   FocusScope.of(context).requestFocus(new FocusNode());
                  // });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  insertcv() async {
    Map<String, dynamic> data = {
      "username": _a.text,
      "lastname": _b.text,
      "title": _c.text,
      "email": _d.text,
      "mobile": _e.text,
      "adress": _f.text,
      "date": _g.text,
      "about": _h.text,
      "education": _i.text,
      "skills": _j.text,
      "experience": _k.text,
      "intere": _l.text,
      "reference": _m.text,
    };

    var response = await networkHandler.patch1("/cv/updatecv", data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        circular = true;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Listcv()),
            (route) => false);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Update with Successfully'),
                        ),
                        SizedBox(
                          width: 320.0,
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      });
    } else if (response.statusCode == 400) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Error'),
                      ),
                      SizedBox(
                        width: 320.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: const Color(0xFF1BC0C5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }
  }
}
