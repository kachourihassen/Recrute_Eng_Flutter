import 'package:flutter/material.dart';
import 'package:gestionuser/Pages/BaccourPage/story/data/users.dart';
import 'package:gestionuser/Pages/BaccourPage/story/page/story_page.dart';




import '../main.dart';

class StoryListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Stories'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: users
                .map((user) => ListTile(
                      title: Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: CircleAvatar(
                          backgroundImage: AssetImage(user.imgUrl)),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StoryPage(user: user),
                          ),
                        );
                      },
                    ))
                .toList(),
          ),
        ),
      );
}
