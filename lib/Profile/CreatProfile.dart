import 'dart:io';

import 'package:flutter/material.dart';

import 'package:gestionuser/Pages/HomePage.dart';
import 'package:image_picker/image_picker.dart';

import '../NetworkHandler.dart';

class CreatProfile extends StatefulWidget {
  CreatProfile({Key key}) : super(key: key);

  @override
  _CreatProfileState createState() => _CreatProfileState();
}

class _CreatProfileState extends State<CreatProfile> {
  final networkHandler = NetworkHandler();
  bool circular = false;
  PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _about = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: double.infinity,
                height: size.height,
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/main_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/login_bottom.png",
                      width: size.width * 0.4,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _globalkey,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      children: <Widget>[
                        imageProfile(),
                        SizedBox(
                          height: 20,
                        ),
                        nameTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        professionTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        dobField(),
                        SizedBox(
                          height: 20,
                        ),
                        titleTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        aboutTextField(),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              circular = true;
                            });
                            if (_globalkey.currentState.validate()) {
                              Map<String, String> data = {
                                "name": _name.text,
                                "profession": _profession.text,
                                "date": _date.text,
                                "titleline": _title.text,
                                "about": _about.text,
                              };
                              var response = await networkHandler.post(
                                  "/profile/add", data);
                              if (response.statusCode == 200 ||
                                  response.statusCode == 201) {
                                if (_imageFile.path != null) {
                                  var imageResponse =
                                      await networkHandler.patchImage(
                                          "/profile/add/image",
                                          _imageFile.path);
                                  if (imageResponse.statusCode == 200) {
                                    setState(() {
                                      circular = false;
                                    });
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()),
                                        (route) => false);
                                  }
                                } else {
                                  setState(() {
                                    circular = false;
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (route) => false);
                                }
                              }
                            }
                          },
                          child: Center(
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: circular
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "Submit",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/images/Login.jpg")
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
              color: Colors.teal,
              size: 28.0,
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

  Widget nameTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _name,
          validator: (value) {
            if (value.isEmpty) return "Name can't be empty";

            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.green,
            ),
            labelText: "Name",
            helperText: "Name can't be empty",
            hintText: " Name",
          ),
        ));
  }

  Widget professionTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _profession,
          validator: (value) {
            if (value.isEmpty) return "Phone number can't be empty";

            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.phone,
              color: Colors.green,
            ),
            labelText: "Phone number ",
            helperText: "Phone number can't be empty",
            hintText: "Phone number",
          ),
        ));
  }

  Widget dobField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
            readOnly: true,
            controller: _date,
            validator: (value) {
              if (value.isEmpty) return "Date Of Birth can't be empty";

              return null;
            },
            decoration: InputDecoration(hintText: 'Pick your Date'),
            onTap: () async {
              var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100));

              _date.text = date.toString().substring(0, 10) ?? null;
            }));
  }
  //    showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2019, 1),
  //     lastDate: DateTime(2021, 12),
  //   ).then((selectedDate) {
  //     if (selectedDate != null) {
  //       _date.text = selectedDate.toString();
  //     }
  //   });
  // }

  // DateTime selectedDate;

  // return DateTimeField(
  //     decoration: const InputDecoration(
  //         hintText: 'Please select your birthday date and time'),
  //     selectedDate: selectedDate,
  //     onDateSelected: (DateTime value) {
  //       setState(() {
  //         selectedDate = value;
  //       });
  //       _date.text = selectedDate.toString() ?? null;
  //     });

  Widget titleTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _title,
          validator: (value) {
            if (value.isEmpty) return "Title can't be empty";

            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            prefixIcon: Icon(
              Icons.title,
              color: Colors.green,
            ),
            labelText: "Title",
            helperText: "It can't be empty",
            hintText: "Flutter Developer",
          ),
        ));
  }

  Widget aboutTextField() {
    return Material(
        elevation: 20.0,
        shadowColor: Colors.black12,
        child: TextFormField(
          controller: _about,
          validator: (value) {
            if (value.isEmpty) return "About can't be empty";

            return null;
          },
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.teal,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
            labelText: "About",
            helperText: "Write about yourself",
            hintText: "I am kachouri",
          ),
        ));
  }
}
// return TextFormField(
//   controller: _date,
//   validator: (value) {
//     if (value.isEmpty) return "Date Of Birth can't be empty";

//     return null;
//   },
//   // decoration: InputDecoration(
//   border: OutlineInputBorder(
//       borderSide: BorderSide(
//     color: Colors.teal,
//   )),
//   focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//     color: Colors.orange,
//     width: 2,
//   )),
//   prefixIcon: Icon(
//     Icons.person,
//     color: Colors.green,
//   ),
//   labelText: "Date Of Birth",
//   helperText: "Provide date on dd/mm/yyyy",
//   hintText: "01/01/2020",
// ),
