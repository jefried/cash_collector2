import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ButtonTransport extends StatelessWidget {
  const ButtonTransport({
    Key? key,
    required this.icon,
    required this.mode,
    required this.onClicked,
    required this.isActive,
    this.time,
    this.distance
  }):super(key: key);
  final IconData icon;
  final String mode;
  final String? time;
  final String? distance;
  final bool isActive;
  final Function onClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClicked();
      },
      child: Container(
        height: 62,
        width: 160,
        decoration: BoxDecoration(
          color: isActive ? routeColor : routeColor.withOpacity(0.7),
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
                time == null ? SizedBox() : SizedBox(
                  width: 120,
                  child: Text(
                    time! + " " + mode,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),
                SizedBox(height: 3,),
                distance == null ? SizedBox() : Text(" (" + distance! + " )", style: const TextStyle(color: Colors.white, fontSize: 14),),
              ],
            )
          ],
        )
      ),
    );
  }

}