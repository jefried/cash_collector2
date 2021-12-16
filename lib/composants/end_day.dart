import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/material.dart';

AlertDialog makeDialogEndDay(BuildContext context) => AlertDialog(
  contentPadding: const EdgeInsets.fromLTRB(6, 4, 6, 0),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14)
  ),
  title: const Text(
    'Clôture de la journée',
    textAlign: TextAlign.left,

  ),
  titlePadding: const EdgeInsets.only(top: 16, left: 18),
  titleTextStyle: const TextStyle(
    fontFamily: 'Poppins Light',
    fontSize: 16,
    color: infosColor1,
  ),
  content: SizedBox(
    height: 100,
    child: Column(
      children: [
        Divider(
          color: infosColor1.withOpacity(0.5),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text(
            'Voulez-vous vraiment clôturer la journée ?',
            style: const TextStyle(
              fontFamily: 'Poppins Medium',
              fontSize: 14.5,
              color: colorText1
            ),
          ),
        ),
      ],
    ),
  ),
  actions: [
    Container(
      height: 45,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: infosColor1
          )
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
        child: Center(
          child: Text(
            'Annuler',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins Light',
              fontSize: 12.5,
              color: infosColor1
            ),
          ),
        ),
      ),
    ),
    Container(
      height: 45,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            secondaryColor,
            principalColor
          ]
        )
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)
        ),
        onPressed: () {

        },
        child: Center(
          child: Text(
            'Clôturer',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Poppins Light',
              fontSize: 12.5,
              color: Colors.white
            ),
          ),
        ),
      ),
    )
  ],
  actionsAlignment: MainAxisAlignment.end,
  actionsPadding: const EdgeInsets.only(bottom: 16, right: 16),
);