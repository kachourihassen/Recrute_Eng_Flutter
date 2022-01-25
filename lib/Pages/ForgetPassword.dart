import 'package:gestionuser/Pages/WelcomPage.dart';
import "package:flutter/material.dart";

import '../NetworkHandler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();

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
        Form(
          key: _globalkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.blue[100],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                usernameTextField(),
                SizedBox(
                  height: 15,
                ),
                passwordTextField(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () async {
                    Map<String, String> data = {
                      "password": _passwordController.text
                    };

                    print("/user/updateps/${_usernameController.text}");
                    var response = await networkHandler.patch(
                        "/user/updateps/${_usernameController.text}", data);

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      print("/user/updateps/${_usernameController.text}");
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePage()),
                          (route) => false);
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff00A86B),
                    ),
                    child: Center(
                      child: circular
                          ? CircularProgressIndicator()
                          : Text(
                              "Update Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    )));
  }

  Widget usernameTextField() {
    return Column(
      children: [
        Text("Username"),
        SizedBox(
          height: 10,
        ),
        Material(
            elevation: 20.0,
            shadowColor: Colors.blue,
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.green,
                  size: 30.0,
                ),
                errorText: validate ? null : errorText,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ))
      ],
    );
  }

  Widget passwordTextField() {
    return Column(
      children: [
        Text("Password"),
        SizedBox(
          height: 10,
        ),
        Material(
            elevation: 20.0,
            shadowColor: Colors.blue,
            child: TextFormField(
              controller: _passwordController,
              obscureText: vis,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.vpn_key_rounded,
                  color: Colors.green,
                  size: 30.0,
                ),
                errorText: validate ? null : errorText,
                suffixIcon: IconButton(
                  icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      vis = !vis;
                    });
                  },
                ),
                helperStyle: TextStyle(
                  fontSize: 14,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
