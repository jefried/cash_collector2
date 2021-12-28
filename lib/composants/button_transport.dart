import 'package:flutter/material.dart';

class ButtonTransport extends StatelessWidget {
  const ButtonTransport({Key? key,this.icon = Icons.directions_car, this.mode = "en voiture", this.time = "10 min", this.distance = "2,8 km"}):super(key: key);
  final IconData icon;
  final String mode;
  final String time;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      width: 160,
      decoration: BoxDecoration(
        color: Color(0xFF075BD5),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        children: [
          Center(
            child: Icon(icon, size: 30, color: Colors.white,),
          ),
          SizedBox(width: 5,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time + " " + mode, style: const TextStyle(color: Colors.white, fontSize: 14),),
              SizedBox(height: 3,),
              Text(" (" + distance + " )", style: const TextStyle(color: Colors.white, fontSize: 14),),
            ],
          )
        ],
      )

      /*ListTile(
        leading: Icon(icon, size: 30, color: Colors.white,),
        title: Text(mode, style: const TextStyle(color: Colors.white, fontSize: 14),),
        subtitle: Text(time + " (" + distance + " )", style: const TextStyle(color: Colors.white, fontSize: 14),),
      ),*/
    );
  }

}