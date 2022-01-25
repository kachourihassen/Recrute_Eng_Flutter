import 'dart:convert';

import 'dart:io' as img;
import 'dart:typed_data';

import 'package:gestionuser/NetworkHandler.dart';
import 'package:gestionuser/Pages/BaccourPage/MyText.dart';
import 'package:gestionuser/Pages/BaccourPage/story/model/Story.dart';
import 'package:gestionuser/Pages/BaccourPage/utility/shared_prefs.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Upload_Story extends StatefulWidget {


  @override
  _Upload_Story createState() => _Upload_Story();
}

class _Upload_Story extends State<Upload_Story> {




  @override
  void initState() {
    super.initState();
  }
  //var

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(

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
  final ImagePicker picker = ImagePicker();
  final networkHandler = NetworkHandler();
  PickedFile imageFile;
  Future<img.File> imageFile2;
  img.File image;
  int _currentValue=0;
  List <String> ChoixList=["java","ajax","html","dart","php"];
  List <String> skil=[];
  String newstring;
  String radio="homme";
  List<String> _locations = ["java","ajax","html","dart","php"]; // Option 2
  String _selectedLocation;

  Image imageFromPreferences;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile2 = ImagePicker.pickImage(source: source);
    });
  }

  loadImageFromPreferences() {
    Utility.getImageFromPreferences("mhamed").then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }
  Widget imageFromGallery() {
    return FutureBuilder<img.File>(
      future: imageFile2,
      builder: (BuildContext context, AsyncSnapshot<img.File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          //print(snapshot.data.path);
          Utility.saveImageToPreferences("mhamed",Utility.base64String(snapshot.data.readAsBytesSync()));
          return Image.file(
            snapshot.data,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

 /* @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    TextEditingController MyController= new TextEditingController();

    return
      ListView(
          children:<Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      getImage();
                    },
                    label: Text("Gallery"),
                  ),
                  MyText(
                    hintText: 'Text',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Saisie le Text';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      //Ajout_Offer_Form.model.salaire = value;
                    },
                  ),

                  RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

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
                  )
                ],
              ),
            ),
          ]
      );
  }*/
  Image image1;

  pickImage(ImageSource source) async {
    final _image = await ImagePicker.pickImage(source: source);

    if (_image != null) {
      setState(() {
        image1 = Image.file(_image);
      });
      ImageSharedPrefs.saveImageToPrefs(
          ImageSharedPrefs.base64String(_image.readAsBytesSync()),_image.path);
    } else {
      print('Error picking image!');
    }
  }

  loadImageFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imageKeyValue = prefs.getString(IMAGE_KEY);
    if (imageKeyValue != null) {
      final imageString = await ImageSharedPrefs.loadImageFromPrefs();
      setState(() {
        image1 = ImageSharedPrefs.imageFrom64BaseString(imageString);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadImageFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              ImageSharedPrefs.emptyPrefs();
              setState(() {
                image1 = null;
              });
            },
          ),
        ],
        title: Text('Save Story'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: image1 == null ? Text('No image selected') : image1,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new ListTile(
                        leading: new Icon(Icons.camera),
                        title: new Text('Camera'),
                        onTap: () {
                          pickImage(ImageSource.camera);
                          // this is how you dismiss the modal bottom sheet after making a choice
                          Navigator.pop(context);
                        },
                      ),
                      new ListTile(
                        leading: new Icon(Icons.image),
                        title: new Text('Gallery'),
                        onTap: () {
                          pickImage(ImageSource.gallery);
                          // dismiss the modal sheet
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Future getImage() async {
    //final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = img.File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.getImage(
      source: source,
    );
    setState(() {
      imageFile = pickedFile;
    });
  }
  void saveStory(Story q) async {
    final response = await http.post(
      "http://192.168.1.7:5000/story//addstory",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "user": "9",
        "caption":q.caption,
        "url":q.url,
      }),
    );
    if (imageFile.path != null)
      var imageResponse = await networkHandler.patchImage(
          "/add/imagestory", image.path);

    if (response.statusCode == 200) {
      print(q.user);

    } else {
      print(response.body);
      throw Exception(response.statusCode);

    }
  }
}
class Utility {
  //


  static Future<String> getImageFromPreferences(String KEY) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY) ?? null;
  }

  static Future<bool> saveImageToPreferences(String value,String KEY) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(KEY, value);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}