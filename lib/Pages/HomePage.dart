import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gestionuser/AI/CvPage.dart';
import 'package:gestionuser/AI/camera.dart';
import 'package:gestionuser/AI/grouplist.dart';
import 'package:gestionuser/AI/listcv.dart';
import 'package:gestionuser/AI/pdf.dart';
import 'package:gestionuser/Pages/BaccourPage/ListOffers.dart';
import 'package:gestionuser/Pages/BaccourPage/story/page/story_list_page.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/acceuilC.dart';
import 'package:gestionuser/Pages/YassinePage/PaiementPage.dart';
import 'package:gestionuser/Pages/YassinePage/YassinePage.dart';
import 'package:gestionuser/Pages/YassinePage/asset_player_widget.dart';
import 'package:gestionuser/Pages/YassinePage/cv_professionel.dart';
import 'package:gestionuser/Profile/ProfileScreen.dart';
import 'package:gestionuser/Screen/HomeScreen.dart';
import 'package:liquid_swipe/Helpers/Helpers.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:toast/toast.dart';

import '../NetworkHandler.dart';
import 'WelcomPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), ProfileScreen()];
  String upgrade = "";
  final storage = FlutterSecureStorage();
  NetworkHandler networkHandler = NetworkHandler();
  String username = "";
  Widget profilePhoto = Container(
    height: 100,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(50),
    ),
  );

  @override
  void initState() {
    checkProfile();
    checkProfile1();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void checkProfile1() async {
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
    RegExp _a = new RegExp(r"(default|gold|Platinum)", caseSensitive: false);
    String _a1 = _a.stringMatch(response1.toString()).toString();
    upgrade = _a1;
  }

  void checkProfile() async {
    var response = await networkHandler.get("/profile/checkProfile");
    setState(() {
      username = response['username'];
    });
    if (response["status"] == true) {
      setState(() {
        profilePhoto = CircleAvatar(
          radius: 50,
          backgroundImage: NetworkHandler().getImage(response['username']),
        );
      });
    } else {
      setState(() {
        profilePhoto = Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
        );
      });
    }
  }

  static const TextStyle goldcoinGreyStyle = TextStyle(
      color: Colors.grey,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "Product Sans");

  static const TextStyle goldCoinWhiteStyle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      fontFamily: "Product Sans");

  static const TextStyle greyStyle =
      TextStyle(fontSize: 40.0, color: Colors.grey, fontFamily: "Product Sans");
  static const TextStyle whiteStyle = TextStyle(
      fontSize: 40.0, color: Colors.white, fontFamily: "Product Sans");

  static const TextStyle boldStyle = TextStyle(
    fontSize: 50.0,
    color: Colors.black,
    fontFamily: "Product Sans",
    fontWeight: FontWeight.bold,
  );

  static const TextStyle descriptionGreyStyle = TextStyle(
    color: Colors.grey,
    fontSize: 20.0,
    fontFamily: "Product Sans",
  );

  static const TextStyle descriptionWhiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Product Sans",
  );

  final pages = [
    Container(
      // color: Color(0xFFFCE4EC),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
          Image.asset("assets/images/h.jpg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "To Help",
                  style: greyStyle,
                ),
                Text(
                  "You",
                  style: boldStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "PLease use the \n"
                  "above CV template\n"
                  "For better job options",
                  style: descriptionGreyStyle,
                ),
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
          Image.asset("assets/images/woman-taking-a-photo-with-her-phone.jpg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Take",
                  style: greyStyle,
                ),
                Text(
                  "a screenshot",
                  style: boldStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Make sure\n"
                  "your CV is clear",
                  style: descriptionGreyStyle,
                ),
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.white70,
      // color: Color(0xFF55006c),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
          Image.asset("assets/images/3323585.jpg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Upload",
                  style: greyStyle,
                ),
                Text(
                  "Your CV",
                  style: boldStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Only PDF format \n"
                  "are allowed ",
                  style: descriptionGreyStyle,
                ),
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Colors.white70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[],
            ),
          ),
          Image.asset("assets/images/3125988.jpg"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Draft",
                  style: greyStyle,
                ),
                Text(
                  "Your CV",
                  style: boldStyle,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Fill the mandatory\n"
                  "field ",
                  style: descriptionGreyStyle,
                ),
              ],
            ),
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Builder(
              builder: (context) => Center(
                child: Stack(
                  children: <Widget>[
                    LiquidSwipe(
                      pages: pages,
                      enableLoop: true,
                      fullTransitionValue: 300,
                      enableSlideIcon: true,
                      waveType: WaveType.liquidReveal,
                      positionSlideIcon: 0.5,
                    ),
                    Positioned(
                      right: 30,
                      bottom: 30,
                      child: Stack(alignment: Alignment.bottomRight, children: <
                          Widget>[
                        IgnorePointer(
                          child: Container(
                            color: Colors.transparent,
                            height: 150.0,
                            width: 150.0,
                          ),
                        ),
                        Transform.translate(
                          offset: Offset.fromDirection(
                              getRadiansFromDegree(270),
                              degOneTranslationAnimation.value * 100),
                          child: Transform(
                            transform: Matrix4.rotationZ(
                                getRadiansFromDegree(rotationAnimation.value))
                              ..scale(degOneTranslationAnimation.value),
                            alignment: Alignment.center,
                            child: CircularButton(
                              color: Colors.blue,
                              width: 50,
                              height: 50,
                              icon: Icon(
                                Icons.create,
                                color: Colors.white,
                              ),
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CvPage("", "", "",
                                          "", "", "", "", "", "", "", "", "")),
                                );
                                print('First Button');
                              },
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset.fromDirection(
                              getRadiansFromDegree(225),
                              degTwoTranslationAnimation.value * 100),
                          child: Transform(
                            transform: Matrix4.rotationZ(
                                getRadiansFromDegree(rotationAnimation.value))
                              ..scale(degTwoTranslationAnimation.value),
                            alignment: Alignment.center,
                            child: CircularButton(
                              color: Colors.black,
                              width: 50,
                              height: 50,
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cam()),
                                );
                                print('Second button');
                              },
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset.fromDirection(
                              getRadiansFromDegree(180),
                              degThreeTranslationAnimation.value * 100),
                          child: Transform(
                            transform: Matrix4.rotationZ(
                                getRadiansFromDegree(rotationAnimation.value))
                              ..scale(degThreeTranslationAnimation.value),
                            alignment: Alignment.center,
                            child: CircularButton(
                              color: Colors.orangeAccent,
                              width: 50,
                              height: 50,
                              icon: Icon(
                                Icons.upload_file,
                                color: Colors.white,
                              ),
                              onClick: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Pdf()),
                                );
                                print('Third Button');
                              },
                            ),
                          ),
                        ),
                        Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value)),
                          alignment: Alignment.center,
                          child: CircularButton(
                            color: Colors.red,
                            width: 60,
                            height: 60,
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                            onClick: () {
                              if (animationController.isCompleted) {
                                animationController.reverse();
                              } else {
                                animationController.forward();
                              }
                            },
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            appBar: AppBar(title: Text(" Recruit Eng")),
            drawer: Drawer(
              child: Drawer(
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(
                        children: <Widget>[
                          profilePhoto,
                          SizedBox(
                            height: 10,
                          ),
                          Text("@$username" + " : " + "$upgrade"),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text("Add Profile"),
                      trailing: Icon(Icons.person_add_alt),
                      onTap: profilpage,
                    ),
                    ListTile(
                      title: Text("List of Offers"),
                      trailing: Icon(Icons.local_offer_outlined),
                      onTap: offre,
                    ),
                    ListTile(
                      title: Text("Online Meet"),
                      trailing: Icon(Icons.photo_camera_front),
                      onTap: Online,
                    ),
                    ListTile(
                      title: Text("List of your Cvs"),
                      trailing: Icon(Icons.list_alt),
                      onTap: listcv,
                    ),

                    ListTile(
                      title: Text("Upgrade"),
                      trailing: Icon(Icons.card_giftcard_rounded),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaiementPage()),
                            (route) => false);
                      },
                    ),
                    // ListTile(
                    //   title: Text("Feedback"),
                    //   trailing: Icon(Icons.feedback),
                    //   onTap: () {},
                    // ),

                    ListTile(
                      title: Text("Professional Cv"),
                      trailing: Icon(Icons.rate_review_outlined),
                      onTap: () {
                        if (upgrade == "Gold") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CvProffesionnel()),
                              (route) => false);
                        } else {
                          Toast.show("Upgrade to Gold ", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }
                      },
                    ),
                    ListTile(
                      title: Text("Story"),
                      trailing: Icon(Icons.photo_camera),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoryListPage()),
                            (route) => false);
                      },
                    ),
                    ListTile(
                      title: Text("Practice"),
                      trailing: Icon(Icons.live_help),
                      onTap: () {
                        if (upgrade == "Gold") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YassinePage()),
                              (route) => false);
                        } else {
                          Toast.show("Upgrade to Gold ", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                        }
                      },
                    ),
                    ListTile(
                      title: Text("Video"),
                      trailing: Icon(Icons.video_collection_outlined),
                      onTap: () {
                        if (upgrade == "Gold") {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AssetPlayerWidget()),
                              (route) => false);
                        } else {
                          Toast.show("Upgrade to Gold ", context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);

                          //print(upgrade);
                        }
                      },
                    ),

                    ListTile(
                      title: Text("Logout"),
                      trailing: Icon(Icons.power_settings_new),
                      onTap: logout,
                    ),
                  ],
                ),
              ),
            )));
  }

  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }

  void profilpage() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
        (route) => false);
  }

  void offre() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AwesomeApp("", "", "", "", "")),
        (route) => false);
  }

  void offre1() async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => ListOffer()), (route) => false);
  }

  void Online() async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomeC()), (route) => false);
  }

  void listcv() async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => Listcv()), (route) => false);
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}
