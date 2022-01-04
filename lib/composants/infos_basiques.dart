import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfosBasiques extends StatelessWidget {
  final String activity;
  final String phoneNumber;
  final String cni;
  final String nameToContact;
  final String phoneNumberToContact;
  final String localisationToContact;
  final String localisation;

  const InfosBasiques({
    Key? key,
    required this.activity,
    required this.phoneNumber,
    required this.cni,
    required this.nameToContact,
    required this.phoneNumberToContact,
    required this.localisationToContact,
    required this.localisation
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle styleText = TextStyle(
      fontSize: 13,
      color: infosColor1
    );
    return Container(
      height: MediaQuery.of(context).size.height - 217,//-217,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text(
                "Secteur d'activité - " + activity,
                style: styleText,
              ),
            ),
            Divider(
              color: infosColor1,
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                "Téléphone  -  " + phoneNumber,
                style: styleText
              ),
            ),
            Divider(
              color: infosColor1,
              indent: 15, endIndent: 15,
            ),
            ListTile(
              leading: Icon(CupertinoIcons.location),
              title: Text(
                localisation,
                style: styleText
              ),
            ),
            Divider(
              color: infosColor1,
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text(
                "CNI  -  " + cni,
                style: styleText
              ),
            ),
            Divider(
              color: infosColor1,
              indent: 15,
              endIndent: 15,
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Personne à contacter",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: infosColor1,
                )
              ),
            ),
            SizedBox(height: 20,),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text(
                nameToContact,
                style: styleText,
              )
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text(
                  "Téléphone  -  " + phoneNumberToContact,
                  style: styleText
              ),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
            ListTile(
              leading: Icon(CupertinoIcons.location),
              title: Text(
                  localisationToContact,
                  style: styleText
              ),
            ),
            Divider(color: infosColor1, indent: 15, endIndent: 15,),
          ],
        ),
      ),
    );
  }
}
