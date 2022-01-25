import 'package:flutter/material.dart';
import 'package:gestionuser/Pages/HomePage.dart';
import 'package:gestionuser/Pages/YassinePage/asset_player_widget.dart';
import 'package:gestionuser/Pages/YassinePage/list_cvprof.dart';
import 'package:gestionuser/Pages/YassinePage/list_employe.dart';
import 'package:gestionuser/Pages/YassinePage/question_page.dart';

class YassinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false)),
            // title: const Text('My Cv'),

            //title: Text("Voir Plus"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Compétences",
                  icon: Icon(Icons.list_sharp),
                ),
                Tab(
                  text: "Questions",
                  icon: Icon(Icons.question_answer_rounded),
                ),
                Tab(
                  text: "Cv Professionel",
                  icon: Icon(Icons.question_answer_rounded),
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
            ListEmploye(),
            QuestionPage(),
            ListCvprof(),
          ]),
        ));
  }
}