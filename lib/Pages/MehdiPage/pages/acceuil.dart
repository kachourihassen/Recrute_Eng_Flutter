import 'package:flutter/material.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/AddRdv1.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/Invitations.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/main.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/meetList.dart';
import 'package:gestionuser/Pages/MehdiPage/pages/chatbot.dart';



void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    DateTimePicker(),
    MyApp(),
    AfficheMeet(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [

          new   BottomNavigationBarItem(
                icon: Icon(Icons.meeting_room),
                title: Text('Set A Meet'),
                backgroundColor: Colors.pinkAccent
            ),
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
