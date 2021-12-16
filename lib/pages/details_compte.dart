import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/button_transport.dart';
import 'package:cash_collector/composants/circular_button.dart';
import 'package:cash_collector/composants/history_transaction.dart';
import 'package:cash_collector/composants/switch_activity_state.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:cash_collector/pages/encaissement.dart';


enum Onglet {
  info, directions, appels
}

class DetailCompte extends StatefulWidget {
  const DetailCompte({Key? key}) : super(key: key);

  @override
  DetailCompteState createState() => DetailCompteState();

}

class DetailCompteState extends State<DetailCompte> with SingleTickerProviderStateMixin {
  Onglet onglet = Onglet.info;
  late TabController tabController;
  int currentIndex = 0;
  bool workStatus = true;
  List transactionsHist = [
    {
      'success': false,
      'datetime': DateTime.utc(2021, 8, 6),
      'amount': 10000,
      'type_transaction': 'in',
      'image_path': 'assets/encaissement/cash.png'
    },
    {
      'success': false,
      'datetime': DateTime(2021, 8, 6),
      'amount': 1000,
      'type_transaction': 'in',
      'image_path': 'assets/images/payment_ways/mtnmomo.png'
    },
    {
      'success': true,
      'datetime': DateTime(2021, 8, 6),
      'amount': 2000,
      'type_transaction': 'in',
      'image_path': 'assets/images/payment_ways/orangemoney.png'
    },
    {
      'success': false,
      'datetime': DateTime(2021, 8, 6),
      'amount': 1500,
      'type_transaction': 'in',
      'image_path': 'assets/images/payment_ways/mtnmomo.png'
    },
    {
      'success': true,
      'datetime': DateTime(2021, 8, 6),
      'amount': 1000,
      'type_transaction': 'in',
      'image_path': 'assets/images/payment_ways/yup.png'
    },
    {
      'success': false,
      'datetime': DateTime(2021, 8, 6),
      'amount': 1000,
      'type_transaction': 'in',
      'image_path': 'assets/images/payment_ways/orangemoney.png'
    },
    {
      'success': false,
      'datetime': DateTime(2021, 8, 6),
      'amount': 1500,
      'type_transaction': 'in',
      'image_path': 'assets/images/payment_ways/mtnmomo.png'
    },
    {
      'success': true,
      'datetime': DateTime(2021, 8, 6),
      'amount': 1000,
      'type_transaction': 'in',
      'image_path': 'assets/images/payment_ways/yup.png'
    },
    {
      'success': false,
      'datetime': DateTime(2021, 8, 6),
      'amount': 1000,
      'type_transaction': 'in',
      'image_path': 'assets/images/payment_ways/orangemoney.png'
    },
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: AppBarContent(
          title: "Ondua Jacqueline",
          icon: Icons.arrow_back_ios,
          onPressBtnMenu: (){Navigator.pop(context);},
        ),
      ),
      body: (onglet == Onglet.info)? SingleChildScrollView(
        child: _body(context),
      ): _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          height: 150,
          child: Stack(
            children: [
              (onglet == Onglet.info && currentIndex == 0)?const Positioned(
                  top: 10,
                  right: 24,
                  child: CircularButton(icon: Icons.create_sharp, foregroundColor: primaryColorAccent,)
              ): Container(),
              Positioned(
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage("assets/details_compte/profil.jpg"),
                                  fit: BoxFit.cover
                              )
                          ),
                        )
                    ),
                  )
              ),
              Positioned(
                bottom: 8,
                left: 0,
                child: Row(
                  children: [
                    const SizedBox(width: 32,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          onglet = Onglet.info;
                        });
                      },
                      child: CircularButton(icon: Icons.person, foregroundColor: (onglet == Onglet.info)?const Color(0xFF075BD5):const Color(0xFF707070), colorShadow: (onglet == Onglet.info)?const Color(0xFF075BD5):const Color(0xFFBEBEBE),),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          onglet = Onglet.directions;
                        });
                      },
                      child: CircularButton(icon: Icons.assistant_direction_rounded, foregroundColor: (onglet == Onglet.directions)?const Color(0xFF075BD5):const Color(0xFF707070), colorShadow: (onglet == Onglet.directions)?const Color(0xFF075BD5):const Color(0xFFBEBEBE),),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          onglet = Onglet.appels;
                        });
                      },
                      child: CircularButton(icon: Icons.phone, foregroundColor: (onglet == Onglet.appels)?const Color(0xFF075BD5):const Color(0xFF707070), colorShadow: (onglet == Onglet.appels)?const Color(0xFF075BD5):const Color(0xFFBEBEBE),),
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 8,
                  right: 0,
                  child: InkWell(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Encaissement()));},
                    child: SizedBox(
                      height: 47,
                      width: 135,
                      child: Stack(
                        children: const [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: BlockButton(text: "Encaisser", foregroundColor: Colors.white, linear: true,),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
        (onglet == Onglet.info)?_info():Container(),
        (onglet == Onglet.directions)?Expanded(child:_directions(context)):Container(),

      ],
    );
  }

  Widget _directions(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height - 217,
      width: double.infinity,
      child: Stack(
        children: [
          HereMap(
            onMapCreated: _onMapCreated,
          ),
          Positioned(
            left: 0,
            bottom: 15,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ButtonTransport(icon: Icons.directions_car, mode: "En Voiture", time: "10 min", distance: "2,8 mi",),
                    SizedBox(width: 10,),
                    ButtonTransport(icon: Icons.directions_walk, mode: "A pied", time: "25 min", distance: "5,8 mi",),
                  ],
                ),
              )
            ),
          )
        ],
      )
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) {
      if (error == null) {
        GeoCoordinates mapCenter = GeoCoordinates(52.530932, 13.384915);
        double distanceToEarthInMeters = 8000;
        hereMapController.camera.lookAtPointWithDistance(mapCenter, distanceToEarthInMeters);

      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });

  }

  Widget _info() {
    return SingleChildScrollView(
      child: Container(
        height: 660,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color(0xFFF3F3FF),
            borderRadius: BorderRadius.only(topRight: Radius.circular(29), topLeft: Radius.circular(29))
        ),
        child: DefaultTabController(
            length: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8,),
                TabBar(
                  controller: tabController,
                  indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(width: 3.0, color: Color(0xFF075BD5)),
                      insets: EdgeInsets.symmetric(horizontal: 40.0)
                  ),
                  tabs: const [
                    Tab(child: Text("Infos", style: TextStyle(color: Color(0xFF707070)),),),
                    Tab(child: Text("Photos", style: TextStyle(color: Color(0xFF707070)),),),
                    Tab(child: Text("Historique", style: TextStyle(color: Color(0xFF707070)),),),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      _infosBasiques(),
                      _photos(),
                      _historique(),
                    ],
                  ),
                ),

              ],
            )

        ),

      ),
    );
  }


  Widget _infosBasiques() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Secteur d'activité - Commerçante", style: TextStyle(fontSize: 13, color: Color(0xFF707070)),),
          ),
          Divider(color: Color(0xFF707070), indent: 15, endIndent: 15,),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Téléphone  -  +237 650 000000", style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
          ),
          Divider(color: Color(0xFF707070), indent: 15, endIndent: 15,),
          ListTile(
            leading: Icon(CupertinoIcons.location),
            title: Text("Marché Melen  -  Yaoundé", style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
          ),
          Divider(color: Color(0xFF707070), indent: 15, endIndent: 15,),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text("CNI  -  100 020 001 000", style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
          ),
          Divider(color: Color(0xFF707070), indent: 15, endIndent: 15,),
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text("Personne à contacter", style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF707070),
            )),
          ),
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Donald Trump", style: TextStyle(fontSize: 13, color: Color(0xFF707070)),),
          ),
          Divider(color: Color(0xFF707070), indent: 15, endIndent: 15,),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Téléphone  -  +237 650 000000", style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
          ),
          Divider(color: Color(0xFF707070), indent: 15, endIndent: 15,),
          ListTile(
            leading: Icon(CupertinoIcons.location),
            title: Text("Marché Melen  -  Yaoundé", style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
          ),
          Divider(color: Color(0xFF707070), indent: 15, endIndent: 15,),
        ],
      ),
    );
  }

  Widget _photos() {
    return Container(width: double.infinity, height: 50, color: Colors.white, margin: const EdgeInsets.symmetric(horizontal: 24));
  }

  Widget _historique() {
    return Container(
        width: double.infinity,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          shrinkWrap: false,
          children: transactionsHist.map(
                  (transaction) => HistoryTransaction(success: transaction['success'], dateTime: transaction['datetime'], amount: transaction['amount'], imagePath: transaction['image_path'], typeTransaction: transaction['type_transaction'])
          ).toList(),
        ),
    );
  }

}