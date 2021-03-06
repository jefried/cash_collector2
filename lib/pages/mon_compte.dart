import 'dart:ui';
import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/history_payment.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/material.dart';

class MonCompte extends StatefulWidget {
  MonCompteState createState() => MonCompteState();
}

class MonCompteState extends State<MonCompte> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;
  bool workStatus = true;
  int solde = 540000;
  String date = "Le 13 Dec. 2021";
  String code = "PRO CENTER RC";
  String noms = "Doe";
  String prenoms = "John";
  String sexe = "maxculin";
  String cni = "000 000 000 000";
  String telephone = "+237 650 000 000";
  String langue = "Français";
  String mdp = "123456";

  List payments = [
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "MTN Mobile Money",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': true,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "Cash",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': false,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "Orange Money",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': false,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "MTN Mobile Money",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': true,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "Cash",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': false,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "Orange Money",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': false,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "MTN Mobile Money",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': true,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "Cash",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': false,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "Orange Money",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': false,
    },
    {
      'name': "Ondua Jacqueline",
      'imageUrl': "assets/details_compte/profil.jpg",
      'paymentWay': "Orange Money",
      'amount': 10000,
      'dateTime': DateTime.now(),
      'success': false,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        currentIndex = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double appBarSize = 81;
    double bannerSize = 150; //205;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: AppBarContent(
          title: "Mon compte",
          icon: Icons.arrow_back_ios,
          onPressBtnMenu: (){Navigator.pop(context);},
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - appBarSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: bannerSize,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        //borderRadius: BorderRadius.only(topRight: Radius.circular(29), topLeft: Radius.circular(29)),
                        image: DecorationImage(
                            image: AssetImage("assets/mon_compte/profil.jpg"),
                            fit: BoxFit.cover
                        )
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 10,
                          left: 20,
                          child: InkWell(
                            onTap: (){},
                            child: const BlockButton(text: "Transférer", linear: true, foregroundColor: Colors.white,),
                          )
                        ),
                        Positioned(
                            bottom: 60,
                            left: 20,
                            child: Container(
                              color: Colors.black.withOpacity(0.6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Votre solde", style: TextStyle(color: Colors.white, fontSize: 12),),
                                  SizedBox(height: 3,),
                                  Text("XAF " + solde.toString(), style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 3,),
                                  Text(date, style: TextStyle(color: Colors.white, fontSize: 12),),
                                ],
                              )
                            )
                        ),
                        Positioned(
                            bottom: 20,
                            right: 20,
                            child: Container(
                              color: Colors.black.withOpacity(0.6),
                              child: Text(code, style: TextStyle(color: Colors.white, fontSize: 17),),
                            )
                        )
                      ],
                    )
                ),
                Container(
                  height: MediaQuery.of(context).size.height - appBarSize - bannerSize,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Color(0xFFF3F3FF),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(29), topLeft: Radius.circular(29))
                  ),
                  child: DefaultTabController(
                      length: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 8,),
                          TabBar(
                            controller: tabController,
                            indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide(width: 3.0, color: Color(0xFF075BD5)),
                                insets: EdgeInsets.symmetric(horizontal: 70.0)
                            ),
                            tabs: const [
                              Tab(child: Text("Profil", style: TextStyle(color: Color(0xFF707070)),),),
                              Tab(child: Text("Historique", style: TextStyle(color: Color(0xFF707070)),),),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                profil(),
                                historique(),
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profil() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBEBEBE),
                    blurRadius: 6,
                    offset: Offset(0,3),
                  )
                ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _listTileProfil("Noms", noms, Icons.lock, textColorGrey),
                const Divider(),
                _listTileProfil("Prénoms", prenoms, Icons.lock, textColorGrey),
                const Divider(),
                _listTileProfil("Sexe", sexe, Icons.lock, textColorGrey),
                const Divider(),
                _listTileProfil("CNI", cni, Icons.lock, textColorGrey),
                const Divider(),
                _listTileProfil("Numéro de téléphone", telephone,Icons.lock, textColorGrey),
                const Divider(),
                _listTileProfil("Langue", langue,Icons.create_sharp, primaryColorAccent),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text("Sécurité", style: TextStyle(color: textColorGrey, fontSize: 16),),
          ),
          const SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFBEBEBE),
                    blurRadius: 6,
                    offset: Offset(0,3),
                  )
                ]
            ),
            child: _listTileProfil("Mot de passe", mdp, Icons.lock, textColorGrey),
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }

  Widget historique() {
    return Container(
      width: double.infinity,
      color: Color(0xFFF3F3FF),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: payments.map((payment) => HistoryPayment(name: payment['name'], dateTime: payment['dateTime'], imageUrl: payment['imageUrl'], amount: payment['amount'], paymentWay: payment['paymentWay'], success: payment['success'])).toList(),
      ),
    );
  }

  Widget _listTileProfil(String title, String subtitle, IconData icon, Color color) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width - 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: textColorGreyAccent, fontSize: 14),),
              SizedBox(height: 5,),
              Text(subtitle, style: TextStyle(color: Colors.black, fontSize: 16),),
            ],
          ),
          Icon(icon, color: color, size: 20,),
        ],
      ),
    );
  }

}