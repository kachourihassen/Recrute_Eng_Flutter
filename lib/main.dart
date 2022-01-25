import 'package:flutter/material.dart';
import 'package:gestionuser/NetworkHandler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'Pages/Storage.dart';
import 'Pages/WelcomPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NetworkHandler networkHandler = NetworkHandler();

  Widget page = WelcomePage();
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");

    if (token != null) {
      setState(() {
        page = StoragePage();
      });
    } else {
      setState(() {
        page = WelcomePage();
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
}
