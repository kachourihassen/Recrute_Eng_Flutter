import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestionuser/NetworkHandler.dart';
import 'package:gestionuser/Pages/HomePage.dart';
import 'package:gestionuser/Pages/SignUpPage.dart';

import 'ForgetPassword.dart';
import 'WelcomPage.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool vis = true;

  final _globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passordController = TextEditingController();
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
                  "Sign In with Email",
                  style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.blue[100],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
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
                InkWell(
                  onTap: () async {
                    Map<String, dynamic> data = {
                      "username": _usernameController.text,
                      "password": _passordController.text,
                    };
                    print(data);
                    var response =
                        await networkHandler.post("/user/login", data);
                    setState(() {
                      circular = true;
                    });

                    if (response.statusCode == 200 ||
                        response.statusCode == 201) {
                      Map<String, dynamic> output = json.decode(response.body);
                      await storage.write(key: 'token', value: output['token']);
                      print(output['token']);
                      var response1 = await networkHandler
                          .get("/user/" + _usernameController.text);
                      RegExp _a = new RegExp(r"(Candidate|Recruiter)",
                          caseSensitive: false);
                      String _a1 =
                          _a.stringMatch(response1.toString()).toString();
                      setState(() {
                        validate = true;
                        circular = false;
                      });
                      if (_a1 == 'Candidate') {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false);
                      } else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomePage()),
                            (route) => false);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Alert"),
                                content: Text("You are not a Candidate"),
                              );
                            });
                      }
                    } else {
                      String output = json.decode(response.body);
                      setState(() {
                        validate = false;
                        errorText = output;
                        circular = false;
                      });
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
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                Divider(
                  height: 50,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        "New User?",
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
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
        Text("Password"),
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
                )),
              ),
            ))
      ],
    );
  }

  Widget passwordTextField() {
    return Column(children: [
      Text("Password"),
      SizedBox(
        height: 10,
      ),
      Material(
          elevation: 20.0,
          shadowColor: Colors.blue,
          child: TextFormField(
            controller: _passordController,
            validator: (value) {
              if (value.isEmpty) return "Password can't be empty";
              return null;
            },
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
            ),
          ))
    ]);
  }
}
