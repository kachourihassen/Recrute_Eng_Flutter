import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import '../NetworkHandler.dart';

import 'WelcomPage.dart';

class SignUpPage extends StatefulWidget {
  //SignUpPage(firstName, {Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

//enum SingingCharacter { candidate, company }

class _SignUpPageState extends State<SignUpPage> {
  bool vis = true;
  bool visc = true;
  final _globalkey = GlobalKey<FormState>();

  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passordController = TextEditingController();
  TextEditingController _confpassordController = TextEditingController();

  String selectedrole = "Candidate";
  String errorText;
  bool validate = false;
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Container(
                height: size.height,
                width: double.infinity,
                child: Stack(alignment: Alignment.center, children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/signup_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/main_bottom.png",
                      width: size.width * 0.25,
                    ),
                  ),
                  Form(
                    key: _globalkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up ",
                          style: TextStyle(
                            fontSize: 35,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3
                              ..color = Colors.red[200],
                          ),
                        ),
                        //SizedBox(height: size.height * 0.03),

                        usernameTextField(),
                        emailTextField(),
                        passwordTextField(),
                        confirmpasswordTextField(),
                        SizedBox(
                          height: 10,
                        ),
                        radioButtonGroup(),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              circular = true;
                            });

                            await checkEmail();
                            await checkPassword();
                            await checkConfPassword();
                            await checkgroupbox();
                            //await checkUser();
                            if (_globalkey.currentState.validate() &&
                                validate) {
                              Map<String, dynamic> data = {
                                "username": _usernameController.text,
                                "email": _emailController.text,
                                "password": _passordController.text,
                                "role": selectedrole,
                              };
                              print(data);

                              await networkHandler.post("/user/register", data);
                              setState(() {
                                circular = false;
                                msg();
                              });
                            } else {
                              setState(() {
                                circular = false;
                              });
                            }
                          },
                          child: circular
                              ? CircularProgressIndicator()
                              : Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xff00A86B),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
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
                          height: 35,
                          thickness: 1.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WelcomePage()));
                              },
                              child: Text(
                                "SignIn",
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
                  )
                ])),
          ),
        ],
      ),
    );
  }

  checkUser() async {
    if (_usernameController.text.length == 0) {
      setState(() {
        circular = false;
        validate = false;
        errorText = "Username can't be empty";
      });
    } else {
      var response = await networkHandler
          .get("/user/checkusername/${_usernameController.text}");
      if (response['Status']) {
        setState(() {
          circular = false;
          validate = false;
          errorText = "Username already existe";
        });
      } else {
        setState(() {
          circular = false;
          validate = true;
        });
      }
    }
  }

  checkEmail() async {
    if (_emailController.text.length == 0) {
      return "Email can't be empty";
    } else if ((!_emailController.text.contains("@")))
      return "Email is invalid @ is missing ";

    setState(() {
      circular = false;
      validate = false;
      errorText = "Email is invalid @ is missing";
    });
  }

  checkPassword() async {
    if (_passordController.text.isEmpty) return "Password can't be empty";
    if (_passordController.text.length <= 8)
      return "Password length should have >=8";
    setState(() {
      circular = false;
      validate = false;
      errorText = "Password length should have >=8";
    });
  }

  checkConfPassword() async {
    if (_confpassordController.text.isEmpty)
      return "Confirm Password can't be empty";
    if (_confpassordController.text != _passordController.text)
      return "Password does not match";
    setState(() {
      circular = false;
      validate = false;
    });
  }

  checkgroupbox() async {
    setState(() {
      circular = false;
      validate = true;
    });
  }

  Widget usernameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
      child: Column(
        children: [
          Text("username"),
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
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
      child: Column(
        children: [
          Text("Email"),
          SizedBox(
            height: 10,
          ),
          Material(
              elevation: 20.0,
              shadowColor: Colors.blue,
              child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty) return "Email can't be empty";
                  if ((!value.contains("@")))
                    return "Email is invalid @ is missing  ";
                  return null;
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.email_outlined,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  )),
                ),
              ))
        ],
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
      child: Column(
        children: [
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
                  if (value.length <= 8)
                    return "Password length should have >=8";
                  return null;
                },
                obscureText: vis,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key_rounded,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        vis = !vis;
                      });
                    },
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  )),
                ),
              ))
        ],
      ),
    );
  }

  Widget confirmpasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
      child: Column(
        children: [
          Text("Confirm password"),
          SizedBox(
            height: 10,
          ),
          Material(
              elevation: 20.0,
              shadowColor: Colors.blue,
              child: TextFormField(
                controller: _confpassordController,
                validator: (value) {
                  if (value.isEmpty) return "Confirm Password can't be empty";
                  if (_confpassordController.text != _passordController.text)
                    return "Password does not match";
                  return null;
                },
                obscureText: visc,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.vpn_key_rounded,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(visc ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        visc = !visc;
                      });
                    },
                  ),
                  helperStyle: TextStyle(
                    fontSize: 16,
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                    width: 2,
                  )),
                ),
              ))
        ],
      ),
    );
  }

  Widget radioButtonGroup() {
    return Container(
      width: 350,
      child: Card(
          color: Colors.white,
          elevation: 20,
          shadowColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: Colors.green,
              width: 1,
            ),
          ),
          child: RadioButtonGroup(
              orientation: GroupedButtonsOrientation.VERTICAL,
              margin: const EdgeInsets.only(left: 60.0),
              labels: <String>[
                "Candidate",
                "Recruiter",
              ],
              labelStyle: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
              onSelected: (String selected) => selectedrole = selected)),
    );
  }

  msg() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
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
                          hintText: 'You are officially Signed up'),
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
  }
}
