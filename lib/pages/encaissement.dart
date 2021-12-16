import 'package:badges/badges.dart';
import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/payment_block.dart';
import 'package:cash_collector/composants/switch_activity_state.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/pages/encaissement2.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

enum PaymentMode {
  orange,
  mtn,
  yup,
  cash
}

class Encaissement extends StatefulWidget {
  const Encaissement({Key? key}) : super(key: key);

  @override
  EncaissementState createState() => EncaissementState();

}

class EncaissementState extends State<Encaissement> {
  bool cash = true;
  PaymentMode paymentMode = PaymentMode.cash;
  bool workStatus=true;

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
        decoration: const BoxDecoration(
            color: Color(0xFFF3F3FF),
            borderRadius: BorderRadius.only(topRight: Radius.circular(29), topLeft: Radius.circular(29))
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text("Sélectionnez un mode", style: TextStyle(fontSize: 20, color: Color(0xFF232323), fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 15,),
              SizedBox(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          paymentMode = PaymentMode.cash;
                        });
                      },
                      child: PaymentBlock(image: "assets/encaissement/cash.png", active: paymentMode == PaymentMode.cash,),
                    ),
                    const SizedBox(width: 30,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          paymentMode = PaymentMode.orange;
                        });
                      },
                      child: PaymentBlock(image: "assets/encaissement/orange.png", active: paymentMode == PaymentMode.orange,),
                    ),
                    const SizedBox(width: 30,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          paymentMode = PaymentMode.mtn;
                        });
                      },
                      child: PaymentBlock(image: "assets/encaissement/mtn.png", active: paymentMode == PaymentMode.mtn,),
                    ),
                    const SizedBox(width: 30,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          paymentMode = PaymentMode.yup;
                        });
                      },
                      child: PaymentBlock(image: "assets/encaissement/yup.png", active: paymentMode == PaymentMode.yup,),
                    ),
                    const SizedBox(width: 10,)
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              (paymentMode != PaymentMode.cash)?
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  height: 58,
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
                  child: const TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                      ),
                      label: Text("Numéro de téléphone", style: TextStyle(color: Color(0xFFBEBEBE)),),
                      hintText: 'Numéro de téléphone',
                    ),
                  ),
              ): Container(),
              const SizedBox(height: 20,),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.only(top: 8),
                  width: MediaQuery.of(context).size.width,
                  height: 58,
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
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                            ),
                            label: Text("Montant à encaisser", style: TextStyle(color: Color(0xFFBEBEBE)),),
                            hintText: 'Montant à encaisser',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 48,
                        width: 48,
                        child: const Center(child: Text("FCFA", style: TextStyle(color: Color(0xFF585757)),),),

                      )
                    ],
                  )
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (_) => _alert("Ondua Jacqueline", "+237 650 000 000", "10 000"),
                      barrierDismissible: false,
                  );
                },
                child: Center(
                  child: _continuerBouton(),
                )
              )
            ],
          ),
        )
      )
    );
  }


  AlertDialog _alert(String name, String number, String montant) {
    return AlertDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.fromLTRB(17.0, 16.0, 0.0, 0.0),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Confirmation de l'encaissement", style: TextStyle(fontSize: 16, color: Color(0xFFA2A2A2)),),
          const SizedBox(height: 30),
          const Text("Noms", style: TextStyle(fontSize: 13, color: Color(0xFFBEBEBE)),),
          const SizedBox(height: 10,),
          Text(name, style: const TextStyle(color: Color(0xFF585757), fontSize: 16),),
          const SizedBox(height: 20),
          const Text("Numéro de téléphone", style: TextStyle(fontSize: 13, color: Color(0xFFBEBEBE)),),
          const SizedBox(height: 10,),
          Text(number, style: const TextStyle(color: Color(0xFF585757), fontSize: 16),),
          const SizedBox(height: 20),
          const Text("Montant à encaisser", style: TextStyle(fontSize: 13, color: Color(0xFFBEBEBE)),),
          const SizedBox(height: 10,),
          Text(montant + "  FCFA", style: const TextStyle(color: Color(0xFF585757), fontSize: 16),),
          const SizedBox(height: 20),
          const Text("Entrez le code de confirmation", style: TextStyle(fontSize: 13, color: Color(0xFFBEBEBE)),),
          const SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.only(right: 18),
            padding: const EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            height: 48,
            decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(15),


            ),
            child: const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 5.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 48,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){Navigator.of(context).pop();},
                child: const BlockButton(text: "Retour", foregroundColor: Color(0xFF707070),),
              ),
              const SizedBox(width: 18,),
              InkWell(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Encaissement2()));},
                child: const BlockButton(text: "Confirmer", foregroundColor: Colors.white, linear: true,),
              ),
              const SizedBox(width: 18,),
            ],
          ),
          const SizedBox(height: 20,)

        ],
      ),

    );
  }

  Widget _continuerBouton() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFFC24644),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                Color(0xFFC24644),
                Color(0xFF8F1716)
              ], // red to yellow
              tileMode: TileMode.repeated, // repeats the gradient over the canvas
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFFBEBEBE),
                blurRadius: 7,
                offset: Offset(0,3),
              )
            ]
        ),
        width: 207,
        height: 43,
        child: const Center(child: Text("Continuer", style: TextStyle(color: Colors.white),),)
    );
  }

}