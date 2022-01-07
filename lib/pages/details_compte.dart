import 'dart:ui';

import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/button_transport.dart';
import 'package:cash_collector/composants/circular_button.dart';
import 'package:cash_collector/composants/direction_to_client.dart';
import 'package:cash_collector/composants/history_transaction.dart';
import 'package:cash_collector/composants/infos_basiques.dart';
import 'package:cash_collector/composants/photos_account.dart';
import 'package:cash_collector/composants/transactions_history.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/models/history_transaction_item.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:cash_collector/pages/encaissement.dart';
import 'package:url_launcher/url_launcher.dart';


enum Onglet {
  info, directions, appels
}

class DetailCompte extends StatefulWidget {
  const DetailCompte({
    Key? key,
    required this.noms,
    required this.localisation,
    required this.geoCoordinates,
    required this.profilImgPath
  }) : super(key: key);
  final String noms;
  final String localisation;
  final String profilImgPath;
  final GeoCoordinates geoCoordinates;

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
          title: widget.noms,
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(widget.profilImgPath),
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
                      child: CircularButton(
                        icon: Icons.person,
                        foregroundColor: (onglet == Onglet.info)?
                        const Color(0xFF075BD5):const Color(0xFF707070),
                        colorShadow: (onglet == Onglet.info)?
                        const Color(0xFF075BD5):const Color(0xFFBEBEBE),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          onglet = Onglet.directions;
                        });
                      },
                      child: CircularButton(
                        icon: Icons.assistant_direction_rounded,
                        foregroundColor: (onglet == Onglet.directions)?
                        const Color(0xFF075BD5):const Color(0xFF707070),
                        colorShadow: (onglet == Onglet.directions)?const Color(0xFF075BD5):const Color(0xFFBEBEBE),),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: () async{
                        /*setState(() {
                          onglet = Onglet.appels;
                        });*/
                        //await FlutterPhoneDirectCaller.callNumber(number);
                        //launch('tel://+237652692742');
                        customLaunch("tel: +237 650000000");
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
                            child: BlockButton(
                              text: "Encaisser",
                              foregroundColor: Colors.white,
                              linear: true,
                            ),
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
        (onglet == Onglet.directions) ?
        Expanded(
          child: DirectionToClient(
            clientName: widget.noms,
            clientCoords: widget.geoCoordinates,
          )
        ):Container(),

      ],
    );
  }


  Widget _info() {
    List<HistoryTransactionItem> transactions = transactionsHist.map(
            (e) =>
            HistoryTransactionItem(
                amount: e['amount'],
                dateTime: e['datetime'],
                typeTransaction: e['type_transaction'],
                logoPath: e['image_path'],
                success: e['success']
            )
    ).toList();

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height - 230, //660,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: backgroundColor1,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(29),
                topLeft: Radius.circular(29)
            )
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
                      borderSide: BorderSide(
                          width: 3.0, color: Color(0xFF075BD5)),
                      insets: EdgeInsets.symmetric(horizontal: 40.0)
                  ),
                  tabs: const [
                    Tab(child: Text(
                      "Infos", style: TextStyle(color: infosColor1),),),
                    Tab(child: Text(
                      "Photos", style: TextStyle(color: infosColor1),),),
                    Tab(child: Text(
                      "Historique", style: TextStyle(color: infosColor1),),),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      InfosBasiques(
                          activity: "Commerçante",
                          phoneNumber: "+237 650 000000",
                          cni: "100 020 001 000",
                          nameToContact: "Donald Trump",
                          phoneNumberToContact: "+237 650 000000",
                          localisationToContact: "Marché Melen - Yaoundé",
                          localisation: widget.localisation
                      ),
                      PhotosAccount(),
                      TransactionsHistory(
                        transactionsHist: transactions,
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

}