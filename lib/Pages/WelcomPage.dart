import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../NetworkHandler.dart';
import 'SgnInPage.dart';
import 'SgnIncompany.dart';
import 'SignUpPage.dart';
import 'LinkedIn.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController _controllerl;
  Animation<Offset> animationl;
  AnimationController _controller2;
  Animation<Offset> animation2;
  Map data;
  NetworkHandler networkHandler = NetworkHandler();
  bool circular = false;

  @override
  void initState() {
    super.initState();
    //animation 1
    _controllerl = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    animationl = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.1),
    ).animate(CurvedAnimation(parent: _controllerl, curve: Curves.easeInOut));
    //animation 2
    _controller2 = AnimationController(
      duration: Duration(milliseconds: 2500),
      vsync: this,
    );
    animation2 = Tween<Offset>(
      begin: Offset(0.0, 8.0),
      end: Offset(0.0, 0.1),
    ).animate(
        CurvedAnimation(parent: _controller2, curve: Curves.elasticInOut));

    _controllerl.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerl.dispose();
    _controller2.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,

        height: size.height,
        width: double.infinity,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.2,
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              children: [
                SlideTransition(
                  position: animationl,
                  child: tst(),
                ),
                SizedBox(
                  height: 25,
                ),
                SvgPicture.asset(
                  "assets/icons/chat.svg",
                  height: size.height * 0.2,
                ),
                SizedBox(height: size.height * 0.05),
                SlideTransition(
                  position: animationl,
                  child: Text(
                    "Welcome ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                boxContainer(
                    "assets/Linkin.png", "Sign up with Linked In", onLinkedIn),
                SizedBox(
                  height: 20,
                ),
                boxContainer(
                    "assets/email.png", "Sign up with Email", onEmailClick),
                SizedBox(
                  height: 20,
                ),
                boxContainer("assets/company.png",
                    "Sign in a Recruiter account", onCompany),
                SizedBox(
                  height: 20,
                ),
                SlideTransition(
                  position: animation2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Candidate Already have an account?",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignInPage(),
                          ));
                        },
                        child: Text(
                          "SignIN",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    ));
  }

  onEmailClick() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }

  onLinkedIn() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LinkedIn(),
    ));
  }

  onCompany() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignIncmPage(),
    ));
  }

  Widget boxContainer(String path, String text, onClick) {
    return SlideTransition(
      position: animation2,
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 40,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Image.asset(
                    path,
                    height: 25,
                    width: 25,
                  ),
                  SizedBox(width: 20),
                  Text(
                    text,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
      width: 300.0,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            " RecruitEng",
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        onTap: () {},
      ),
    );
  }

  // Widget _buildMenuBar(BuildContext context) {
  //   return Container(
  //     width: 300.0,
  //     height: 50.0,
  //     decoration: const BoxDecoration(
  //       color: Color(0x552B2B2B),
  //       borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //     ),
  //     child: CustomPaint(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: <Widget>[
  //           Expanded(
  //             child: TextButton(
  //               style: ButtonStyle(
  //                 overlayColor: MaterialStateProperty.all(Colors.transparent),
  //               ),
  //               onPressed: () {
  //                 Navigator.pushReplacement(context,
  //                     MaterialPageRoute(builder: (context) => SignUpPage()));
  //               },
  //               child: Text(
  //                 'Existing',
  //                 style:
  //                     TextStyle(fontSize: 16.0, fontFamily: 'WorkSansSemiBold'),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: TextButton(
  //               style: ButtonStyle(
  //                 overlayColor: MaterialStateProperty.all(Colors.transparent),
  //               ),
  //               onPressed: () {
  //                 Navigator.pushReplacement(context,
  //                     MaterialPageRoute(builder: (context) => SignUpPage()));
  //               },
  //               child: Text(
  //                 'New',
  //                 style:
  //                     TextStyle(fontSize: 16.0, fontFamily: 'WorkSansSemiBold'),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
