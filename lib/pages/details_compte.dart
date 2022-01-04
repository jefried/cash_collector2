import 'dart:ui';

import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/button_transport.dart';
import 'package:cash_collector/composants/circular_button.dart';
import 'package:cash_collector/composants/history_transaction.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:cash_collector/pages/encaissement.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cash_collector/helpers/colors.dart';


enum Onglet {
  info, directions, appels
}

class DetailCompte extends StatefulWidget {
  const DetailCompte({Key? key, required this.noms, required this.localisation}) : super(key: key);
  final String noms;
  final String localisation;

  @override
  DetailCompteState createState() => DetailCompteState();

}

class DetailCompteState extends State<DetailCompte> with SingleTickerProviderStateMixin {
  Onglet onglet = Onglet.info;
  late TabController tabController;
  int currentIndex = 0;
  bool workStatus = true;
  String activite = "Commerçante";
  String telephone = "+237 650 000000";
  String cni = "100 020 001 000";
  String nomAContacter = "Donald Trump";
  String telephoneAContacter = "+237 650 000000";
  String localisationAContacter = "Marché Melen - Yaoundé";
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

  void customLaunch(command) async {
    if(await canLaunch(command)) {
      await launch(command);
    } else {
      print(' could not launch $command');
    }
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
                      onTap: () async{
                        /*setState(() {
                          onglet = Onglet.appels;
                        });*/
                        //await FlutterPhoneDirectCaller.callNumber(number);
                        //launch('tel://+237652692742');
                        customLaunch('tel:${telephone}');
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
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Encaissement(noms: widget.noms,)));},
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
                    ButtonTransport(icon: Icons.directions_car, mode: "en Voiture", time: "10 min", distance: "2,8 km",),
                    SizedBox(width: 10,),
                    ButtonTransport(icon: Icons.directions_walk, mode: "à pied", time: "25 min", distance: "5,8 km",),
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
        height: MediaQuery.of(context).size.height - 230,//660,
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
      height: MediaQuery.of(context).size.height - 217,//-217,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text("Secteur d'activité - " + activite, style: TextStyle(fontSize: 13, color: Color(0xFF707070)),),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Téléphone  -  " + telephone, style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
            ListTile(
              leading: Icon(CupertinoIcons.location),
              title: Text(widget.localisation, style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text("CNI  -  " + cni, style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text("Personne à contacter", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: infosColor1,
              )),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text(nomAContacter, style: TextStyle(fontSize: 13, color: Color(0xFF707070)),),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Téléphone  -  " + telephoneAContacter, style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
            ListTile(
              leading: Icon(CupertinoIcons.location),
              title: Text(localisationAContacter, style: TextStyle(fontSize: 13, color: Color(0xFF707070))),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
          ],
        ),
      ),
    );
  }

  Widget _photos() {
    return Container(
        width: double.infinity,
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
          children: [
            Container(
              height: 176,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/details_compte/photo_indisponible.jpg",),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFBEBEBE),
                      blurRadius: 2.0,
                      offset: Offset(0,3),
                    )
                  ]
              ),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                        child: Text("Photo du lieu", style: TextStyle(color: Colors.white, fontSize: 17),),
                      )
                  ),
                ],
              )
            ),
            const SizedBox(height: 30,),
            Container(
              height: 176,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/details_compte/photo_indisponible.jpg"),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFBEBEBE),
                      blurRadius: 2.0,
                      offset: Offset(0,3),
                    )
                  ]
              ),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                        child: Text("Photo CNI (recto)", style: TextStyle(color: Colors.white, fontSize: 17),),
                      )
                  ),
                ],
              )
            ),
            const SizedBox(height: 30,),
            Container(
              height: 176,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/details_compte/photo_indisponible.jpg"),
                    fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFBEBEBE),
                      blurRadius: 2.0,
                      offset: Offset(0,3),
                    )
                  ]
              ),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 20,
                      right: 20,
                      child: Container(
                        color: Colors.black.withOpacity(0.6),
                        child: Text("Photo CNI (verso)", style: TextStyle(color: Colors.white, fontSize: 17),),
                      )
                  ),
                ],
              )
            ),
            const SizedBox(height: 30,),
      ],
    ),
        ),
    );
  }

  Widget _historique() {
    return Container(
        width: double.infinity,
        color: Color(0xFFF3F3FF),
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