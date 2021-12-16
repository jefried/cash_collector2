import 'package:badges/badges.dart';
import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/circular_button.dart';
import 'package:cash_collector/composants/switch_activity_state.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/pages/home.dart';
import 'package:cash_collector/pages/mon_compte.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Encaissement2 extends StatefulWidget {
  const Encaissement2({Key? key}) : super(key: key);

  @override
  Encaissement2State createState() => Encaissement2State();

}

class Encaissement2State extends State<Encaissement2> {
  bool cash = true;
  bool workStatus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(57),
          child: AppBarContent(
            title: "Encaissement",
            icon: Icons.arrow_back_ios,
            onPressBtnMenu: (){Navigator.pop(context);},
          ),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height - 72,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Color(0xFFF3F3FF),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(29),
                    topLeft: Radius.circular(29))
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Image(image: AssetImage("assets/encaissement/check.png"),),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("Encaissement réussi", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, ),),
                  SizedBox(height: 20,),
                  Container(
                    height: 357,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: 314,
                            width: MediaQuery.of(context).size.width - 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFBEBEBE),
                                    blurRadius: 6,
                                    offset: Offset(0,3),
                                  )
                                ]
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 16),
                                Text("Détails de la transaction", style: TextStyle(color: textColorGrey, fontSize: 18),),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Container(
                                      width: (MediaQuery.of(context).size.width - 50)/2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text("Montant ", style: TextStyle(color: textColorGreyAccent),),
                                          SizedBox(height: 15,),
                                          Text("Mode ", style: TextStyle(color: textColorGreyAccent),),
                                          SizedBox(height: 15,),
                                          Text("Date ", style: TextStyle(color: textColorGreyAccent),),
                                          SizedBox(height: 15,),
                                          Text("ID transaction ", style: TextStyle(color: textColorGreyAccent),),
                                          SizedBox(height: 15,),
                                          Text("Bénéficiaire ", style: TextStyle(color: textColorGreyAccent),),
                                          SizedBox(height: 15,),
                                          Text("Numéro de téléphone ", style: TextStyle(color: textColorGreyAccent),),
                                          SizedBox(height: 15,),
                                          Text("Agent ", style: TextStyle(color: textColorGreyAccent),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: (MediaQuery.of(context).size.width - 50)/2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("  "+"10 000"+" CFA", style: TextStyle(fontSize: 13),),
                                          SizedBox(height: 15,),
                                          Text("  "+"Orange Money", style: TextStyle(fontSize: 13),),
                                          SizedBox(height: 15,),
                                          Text("  "+"11:00 4 Dec. 2021", style: TextStyle(fontSize: 13),),
                                          SizedBox(height: 15,),
                                          Text("  "+"CXO 0071 - SDE001GFE", style: TextStyle(fontSize: 13),),
                                          SizedBox(height: 15,),
                                          Text("  "+"Ondua Jacqueline", style: TextStyle(fontSize: 13),),
                                          SizedBox(height: 15,),
                                          Text("  "+"+237 650 000 000", style: TextStyle(fontSize: 13),),
                                          SizedBox(height: 15,),
                                          Text("  "+"PRO Center RC", style: TextStyle(fontSize: 13),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 50,
                            child: Center(
                              child: CircularButton(icon: Icons.local_print_shop, foregroundColor: primaryColorAccent, size: 87, sizeIcon: 50, colorShadow: Colors.cyan,),
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  _accueilButton(),
                  SizedBox(height: 50,)
                ],
              ),
            )
        )
    );
  }

  Widget _accueilButton() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Color(0xFFDEDEDE),
        ),
        width: 104,
        height: 48,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
          },
          child: Center(child: Text("Accueil", style: TextStyle(color: Colors.black),),),
        )
    );
  }
}