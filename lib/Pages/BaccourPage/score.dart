
// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:timer_count_down/timer_controller.dart';

// final isRestart= StateProvider((ref)=>false);
// final isPause= StateProvider((ref)=>false);
// void main() => runApp(AfficheScore());

// class AfficheScore extends StatefulWidget {
//   @override
//   _MyAfficheScore createState() => _MyAfficheScore(sco);
//   int sco;
//   AfficheScore({Key key, @required this.sco}) : super(key: key);
// }

// class _MyAfficheScore extends State<AfficheScore>  {
//   int sco;
//   _MyAfficheScore(int o)
//   {
//     this.sco=o;
//   }
//   @override
//   void dispose() {

//     super.dispose();
//   }
//   @override
//   void initState() {

//     super.initState();
//   }
//   //var



//   @override
//   Widget build(BuildContext context) {
//     //Size size = MediaQuery.of(context).size;


//     return Scaffold(
//       appBar: AppBar(
//         title:  Text("Score"),

//       ),
//       body:


//       ListView(
//           children:[
//             /* Text('Titre'
//                 ),
//                 MyText(
//                   hintText: 'Titre',
//                   enable: false,
//                   Controller: TitreC,
//                 ),*/
//             Center(
//                 child:Text(((sco*100)/8).toString()+"/100", style: TextStyle(height: 5, fontSize: 24) ,
//                 )

//             ),

//             SizedBox(
//               height: 70,
//             )
//           ] ),






//     );


//   }


// }