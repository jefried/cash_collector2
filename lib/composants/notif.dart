import 'package:cash_collector/style/colors.dart';
import 'package:flutter/material.dart';

class Notif extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.fromLTRB(4, 5, 4, 5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: textColorGreyAccent,
            blurRadius: 9,
            offset: Offset(3,3),
          )
        ]
      ),
      child: Row(
        children: [
          Container(
            height: 43,
            width: 47,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                image: AssetImage("assets/details_compte/profil.jpg"),
                fit: BoxFit.cover,
              )
            ),
          ),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Création de compte", style: TextStyle(fontSize: 12, color: Color(0xFF303030), fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                    SizedBox(width: 4,),
                    Expanded(child: Text("Jacqueline Onduafdfdfdfdfdfdffdfdfdfdfdfdfdfddfdfdfdfd", style: TextStyle(fontSize: 11, color: stepperColor), overflow: TextOverflow.ellipsis,))
                  ],
                ),
                SizedBox(height: 2,),
                Row(
                  children: [
                    Text("15 Dec 2021", style: TextStyle(fontSize: 11, color: textColorGrey), overflow: TextOverflow.ellipsis,),
                    SizedBox(width: 4,),
                    Text("A l'instant", style: TextStyle(fontSize: 11, color: textColorGrey), overflow: TextOverflow.ellipsis,)
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.circle, size: 7, color: Color(0xFFFF4747),),
              Icon(Icons.person_add_alt_1_rounded, size: 25, color: textColorGreyAccent,),
            ],
          )
        ],
      ),
    );
  }

}