import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/helpers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPayment extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String paymentWay;
  final num amount;
  final DateTime dateTime;
  final bool success;
  const HistoryPayment({
    Key? key,
    required this.name,
    required this.dateTime,
    required this.imageUrl,
    required this.amount,
    required this.paymentWay,
    required this.success
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shadowColor2.withOpacity(0.29),
            offset: const Offset(1, 3),
            blurRadius: 2
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: shadowColor2.withOpacity(.29),
                          offset: const Offset(0, 3),
                          blurRadius: 22
                      )
                    ]
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontFamily: 'Poppins Regular',
                        fontSize: 12,
                        color: colorText1
                    ),
                  ),
                  Text(
                    formatMoney(amount, 'fr'),
                    style: const TextStyle(
                        fontFamily: 'Poppins Medium',
                        fontSize: 12,
                        color: infosColor1
                    ),
                  ),
                  Text(
                    paymentWay,
                    style: const TextStyle(
                        fontFamily: 'Poppins Light',
                        fontSize: 10,
                        color: colorText2
                    ),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                success ? CupertinoIcons.check_mark_circled_solid : CupertinoIcons.xmark_circle_fill,
                size: 32,
                color: success ? successColor : dangerColor,
              ),
              Text(
                formatDateTime(dateTime, 'fr'),
                style: const TextStyle(
                  fontFamily: 'Poppins Light',
                  color: infosColor1,
                  fontSize: 10
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
