import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:gestionuser/ModelAnnonce/Offer.dart';
import 'package:gestionuser/ModelQuestion/question.dart';
import 'package:gestionuser/Pages/BaccourPage/CreatOffer.dart';
import 'package:gestionuser/Pages/HomeRec.dart';
import 'package:http/http.dart' as http;

class Ajout_Qcm_Form extends StatefulWidget {
  @override
  _Ajout_Qcm_Form createState() => _Ajout_Qcm_Form();
}

class _Ajout_Qcm_Form extends State<Ajout_Qcm_Form> {




  @override
  void initState() {
    super.initState();
  }
  //var

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(

            body:
            TestForm()

        ));


  }


}
class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  @override
  void initState() {
    super.initState();
    yourFunction();
  }
  final _formKey = GlobalKey<FormState>();
  Offer model = Offer();
//var
  var fList;
  List<Question>quizList=[];
  Offer f=Ajout_Offer_Form.model;
  List<dynamic> caches;
  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;


    //getoffer();
    //fetchData();
    // print(caches.length);
    return
      Scaffold(
          appBar: AppBar(
            title: const Text('Creé Quiz'),
            actions: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.add_comment),
                  onPressed: (){
                    setState(() {

                      print(Ajout_Offer_Form.model.skills);
                    });
                  }
              )
            ],
          ),
          body:

          SingleChildScrollView(
            child: new Column(
              children:<Widget>[
                new ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: quizList.length,
                    itemBuilder: (BuildContext cntxt,int index){
                      return new Column(
                        children: <Widget>[

                          Container(
                            child:new Text('Question',
                              style: TextStyle(color: Colors.black),) ,

                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(color: Colors.blue, spreadRadius: 3),
                              ],
                            ),
                          ),
                          Container(
                            child:new Text(quizList[index].Questin,
                              style: TextStyle(color: Colors.black),) ,

                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(color: Colors.blue, spreadRadius: 3),
                              ],
                            ),
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                  //boxShadow: [
                                  //  BoxShadow(color: Colors.blue, spreadRadius: 5),
                                  // ],
                                ),
                                child: Row(
                                  children: [
                                    Container(

                                      child:new Text('A',
                                        style: TextStyle(color: Colors.black),) ,
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.blue, spreadRadius: 3),
                                        ],
                                      ),


                                    ),

                                    new Text(quizList[index].a1),
                                  ],
                                ),
                              ),
                            ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                  //boxShadow: [
                                  //  BoxShadow(color: Colors.blue, spreadRadius: 5),
                                  // ],
                                ),
                                child: Row(
                                  children: [
                                    Container(

                                      child:new Text('B',
                                        style: TextStyle(color: Colors.black),) ,
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.blue, spreadRadius: 3),
                                        ],
                                      ),


                                    ),

                                    new Text(quizList[index].a2),
                                  ],
                                ),),
                            ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                  //boxShadow: [
                                  //  BoxShadow(color: Colors.blue, spreadRadius: 5),
                                  // ],
                                ),
                                child: Row(
                                  children: [
                                    Container(

                                      child:new Text('C',
                                        style: TextStyle(color: Colors.black),) ,
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.blue, spreadRadius: 3),
                                        ],
                                      ),


                                    ),

                                    new Text(quizList[index].a3),
                                  ],
                                ),),
                            ],),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue,
                                  //boxShadow: [
                                  //  BoxShadow(color: Colors.blue, spreadRadius: 5),
                                  // ],
                                ),

                                child: Row(
                                  children: [
                                    Container(

                                      child:new Text('D',
                                        style: TextStyle(color: Colors.black),) ,
                                      padding: EdgeInsets.all(10.0),
                                      margin: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(color: Colors.blue, spreadRadius: 3),
                                        ],
                                      ),


                                    ),

                                    new Text(quizList[index].a4),
                                  ],
                                ),),
                            ],),
                        ],
                      );

                    }),
                Container(
                  child:FlatButton.icon(onPressed:(){
                    //for(Quiz q in quizList)
                    //  save(q);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeRecPage()),
                    );
                  },
                    icon:Icon(Icons.save),
                    label: Text('Save'),
                  ),

                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[900],
                    boxShadow: [
                      BoxShadow(color: Colors.blue, spreadRadius: 3),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          ));
  }


  /*void save(Quiz q) async {

    final response = await http.post(
      "http://192.168.43.62:5000/qcm/ajoutqcm",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "idQ": 5,
        "id": 6,
        "idCondidat": 7,
        "question": q.Questin,
        "answer1": q.reponse1,
        "answer2": q.reponse2,
        "answer3": q.reponse3,
        "answer4": q.reponse4,
        "reponse1": q.a1.toString(),
        "reponse2": q.a2.toString(),
        "reponse3": q.a3.toString(),
        "reponse4": q.a4.toString(),

      }),
    );

    if (response.statusCode == 200) {
      print(q.Questin);
    } else {
      throw Exception(response.statusCode);
    }
  }*/
  /*void fetchData() async {

    var response = await networkHandler.get("/offer/findoffer");
    setState(() {
      model= Offer.fromJson(response["data"]);
print( model.idUser);
    });
  }*/
  /*void getoffer()async {
    final urlList = ["http://192.168.43.62:5000/offer/findoffer"];

    final responses = await Future.wait(
      urlList.map((String url) {
        return http.get(url);
      }),
    );

      caches = responses.map((response) {
      return (json.decode(response.body) as List)
          .map((data) => Offer.fromJson(data))
          .toList();
    }).toList();

     fList = List<Offer>.from(caches[0]);
    //for(Offer titre in fList )
      //offerTitre.add("titre.titre");
print(fList[0]);
  }*/
  Future<List<Question>> findquestion()async {
    final urlList = ["http://192.168.1.3:5000/question/findquestion"];
    print("dfdfg");
    final responses = await Future.wait(
      urlList.map((String url) {
        return http.get(url);
      }),
    );

    caches = responses.map((response) {
      return (json.decode(response.body) as List)
          .map((data) => Question.fromJson(data))
          .toList();
    }).toList();
    print(caches[0]);
    fList = List<Question>.from(caches[0]);
    //for(Offer titre in fList )
    //offerTitre.add("titre.titre");
    Question question=new Question();
    for(Question q in fList){
      question.type=q.type;
      question.Questin=q.Questin;
      question.reponse1=q.reponse1;
      question.reponse2=q.reponse2;
      question.a1=q.a1;
      question.a2=q.a2;
      question.a3=q.a3;
      question.a4=q.a4;
      question.reponse3=q.reponse3;
      question.reponse4=q.reponse4;
    }
    return fList;

  }
  void yourFunction() {
    findquestion().then((value) {
      setState(() {
        quizList=value;
      });
    });
    print("Loaded");

  }

}