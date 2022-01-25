import 'package:flutter/material.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/AddRdv1.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/Invitations.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/afficheMeetC.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/main.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/meetList.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/chatbot.dart';



void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeC(),
    );
  }
}

class HomeC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeStateC();
  }
}

class _HomeStateC extends State<HomeC> {
  int _currentIndex = 0;
  final List<Widget> _children = [

    MyApp(),
    AfficheMeetC(),
    HelpBot(),
    Invitation(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [


          new  BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              title: Text('Join your meet'),
              backgroundColor: Colors.pinkAccent
          ),
          new   BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list),
              title: Text('Check your meets'),
              backgroundColor: Colors.pinkAccent
          ),
          new   BottomNavigationBarItem(
              icon: Icon(Icons.help_center_outlined),
              title: Text('Tips'),
              backgroundColor: Colors.pinkAccent
          ),
          new   BottomNavigationBarItem(
              icon: Icon(Icons.email),
              title: Text('Invitations'),
              backgroundColor: Colors.pinkAccent
          ),
        ],

      ),

    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}
