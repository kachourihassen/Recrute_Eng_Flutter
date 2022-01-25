import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:google_fonts/google_fonts.dart';

import '../NetworkHandler.dart';
import 'HomePage.dart';
import 'HomeRec.dart';
import 'WelcomPage.dart';

class StoragePage extends StatefulWidget {
  StoragePage({Key key}) : super(key: key);

  @override
  _StoragePageState createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  Widget page = WelcomePage();
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";

  @override
  initState() {
    super.initState();
    checkProfile();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {});
    } else {
      setState(() {});
    }
    checkuser();
  }

  void checkuser() async {
    var response1 = await networkHandler.get("/user/" + username.toString());
    RegExp _a = new RegExp(r"(Candidate|Recruiter)", caseSensitive: false);
    String _a1 = _a.stringMatch(response1.toString()).toString();
    if (_a1 == 'Candidate') {
      setState(() {
        //page = HomePage();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
      });
    } else if (_a1 == 'Recruiter') {
      setState(() {
//page = HomeRecPage();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomeRecPage(),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: page,
    );
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }

  Widget tst() {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );

    return SizedBox(
      width: 250.0,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            " Recruteng",
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        onTap: () {},
      ),
    );
  }
}
