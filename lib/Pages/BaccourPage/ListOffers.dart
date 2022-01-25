import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gestionuser/ModelAnnonce/Offer.dart';
import 'package:gestionuser/Pages/BaccourPage/OfferListview.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ListOffer extends StatefulWidget {
  @override
  _ListOfferState createState() => _ListOfferState();

}

class _ListOfferState extends State<ListOffer>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offer> hotelList=[];
  List<Offer> fList;
  List<Offer>OfferList=[];


  List<dynamic> caches;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {

    animationController = AnimationController(
        duration: const Duration(milliseconds: 10), vsync: this);
    super.initState();
    yourFunction();
  }

  Future<bool> getData() async {

    await Future<dynamic>.delayed(const Duration(milliseconds: 2));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  Future<List<Offer>> getOffer()async {
    final urlList = ["http://192.168.1.3:5000/annonce/findoffer"];
    print("dfdfg");
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
    print(caches[0]);
    fList = List<Offer>.from(caches[0]);
    //for(Offer titre in fList )
    //offerTitre.add("titre.titre");
    /*Offer offer=new Offer();
    for(Offer q in fList){
      offer.titre=q.titre;
      offer.user=q.user;
      offer.description=q.description;
      offer.skill=q.skill;
      offer.post= q.post;
      offer.descentr= q.descentr;
      offer.typecont=q.typecont;
      offer.sexe= q.sexe;
      offer.adresse= q.adresse;
      offer.salaire= q.salaire;
      // QuizList.add(quiz);
    }*/
    return fList;

  }
  void yourFunction() {
    //OfferList=await getOffer();
    getOffer().then((value) {
      setState(() {
        OfferList=value;
      });
    });
    print("Loaded");

  }
  @override
  Widget build(BuildContext context) {



    /* for(int i=0;i<=OfferList.length-1;i++)
      hotelList.add(HotelListData(
        imagePath: 'assets/hotel/company1.jpg',
        titleTxt: OfferList[i].titre,
        subTxt: 'Wembley, London',
        dist: 2.0,
        reviews: 80,
        rating: 4.4,
        perNight: 180,
      ));*/
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
     Scaffold(
       appBar: AppBar(
         title:  Text("Offers"),

       ),
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {

                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[

                          ];
                        },
                        body: Container(

                          child: ListView.builder(
                            itemCount: OfferList.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              print("ListView.builder");
                              print(OfferList[index].adress);
                              final int count =
                              hotelList.length > 10 ? 10 : hotelList.length;
                              final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval(
                                          (1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return OfferListView(
                                callback: () {},
                                offer: OfferList[index],
                                animation: animation,
                                animationController: animationController,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));

  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(

        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      print(index);
                      final int count =
                      hotelList.length > 10 ? 10 : hotelList.length;
                      final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return OfferListView(
                        callback: () {},
                        offer: OfferList[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < hotelList.length; i++) {
      final int count = hotelList.length;
      final Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        OfferListView(
          callback: () {},
          offer: OfferList[i],
          animation: animation,
          animationController: animationController,
        ),
      );
    }
    animationController.forward();
    return Column(
      children: hotelListViews,
    );
  }












}
