import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/helpers/utils.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HistoryTransaction extends StatelessWidget {

  final bool success;
  final DateTime dateTime;
  final num amount;
  final String imagePath;
  final String typeTransaction;

  const HistoryTransaction({
    Key? key,
    required this.success,
    required this.dateTime,
    required this.amount,
    required this.imagePath,
    required this.typeTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String transaction = "";
    if (typeTransaction == 'in'){
      transaction = 'Dépôt';
    }
    else if(typeTransaction == 'out'){
      transaction = 'Retrait';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: textColorGreyAccent,
            offset: const Offset(3, 3),
            blurRadius: 9,
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                success ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.xmark_circle_fill,
                size: 45,
                color: success ? successColor : dangerColor,
              ),
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction,
                    style: const TextStyle(
                      fontFamily: 'Poppins Regular',
                      fontSize: 12,
                      color: infosColor1
                    ),
                  ),
                  Text(
                    formatMoney(amount, 'fr'),
                    style: const TextStyle(
                      fontFamily: 'Poppins Light',
                      fontSize: 15,
                      color: colorText1
                    ),
                  ),
                  Text(
                    formatDateTime(dateTime, 'fr'),
                    style: TextStyle(
                      fontFamily: 'Poppins Regular',
                      fontSize: 11,
                      color: colorText1.withOpacity(0.5)
                    ),
                  ),
                ],
              )
            ],
          ),
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.fill
              ),
              shape: BoxShape.circle
            )
          )
        ],
      ),
    );
  }
}