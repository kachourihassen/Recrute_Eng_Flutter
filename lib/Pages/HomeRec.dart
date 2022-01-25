import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gestionuser/Pages/BaccourPage/CreatOffer.dart';
import 'package:gestionuser/Pages/BaccourPage/story/uploadStory.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/acceuil.dart';

import 'package:gestionuser/Profile/ProfileScreen.dart';
import 'package:gestionuser/Screen/HomeScreen.dart';
import 'package:gestionuser/Societe/SocieteScreen.dart';

import '../NetworkHandler.dart';
import 'WelcomPage.dart';

class HomeRecPage extends StatefulWidget {
  HomeRecPage({Key key}) : super(key: key);

  @override
  _HomeRecPageState createState() => _HomeRecPageState();
}

class _HomeRecPageState extends State<HomeRecPage>
    with SingleTickerProviderStateMixin {
  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  int currentState = 0;
  List<Widget> widgets = [HomeScreen(), ProfileScreen()];

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

    super.initState();
    {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void checkProfile() async {
    var response = await networkHandler.get("/societe/checkSociete");
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Recruit Eng")),
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
                          Text("@$username"),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text("Add Company"),
                      trailing: Icon(Icons.person_add_alt),
                      onTap: profilpage,
                    ),

                    // ListTile(
                    //   title: Text("Feedback"),
                    //   trailing: Icon(Icons.feedback),
                    //   onTap: () {},
                    // ),
                    ListTile(
                      title: Text("Logout"),
                      trailing: Icon(Icons.power_settings_new),
                      onTap: logout,
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Ajout_Offer_Form(),
                        ));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/images/imageoffer.jpg"),
                          Center(child: Text("Make an Offer"))
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Upload_Story(),
                        ));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/images/stories.jpg"),
                          Center(child: Text("Upload Story"))
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                  Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Home(),
                        ));
                      },
                      child: Column(
                        children: [
                          Image.asset("assets/images/meet.jpg"),
                          Center(child: Text("Online Meet"))
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ],
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
        MaterialPageRoute(builder: (context) => SocieteScreen()),
        (route) => false);
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
