import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/client_present_item.dart';
import 'package:cash_collector/composants/home_drawer.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/material.dart';

class HomeClientsList extends StatelessWidget {
  const HomeClientsList({
    Key? key
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;

    final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

    List<Map<String, dynamic>> clientsInfos = [
      {
        'id': 1,
        'name': 'Sondi Manga',
        'adress': 'Melen, Yaoundé',
        'latitude': 3.8754212,
        'longitude': 11.511222
      },
      {
        'id': 2,
        'name': 'Malina Jenevièvre',
        'adress': 'Oyomabang, Yaoundé',
        'latitude': 3.8712532,
        'longitude': 11.5184521
      },
      {
        'id': 3,
        'name': 'Lili goumette',
        'adress': 'Melen, Yaoundé',
        'latitude': 3.8798451,
        'longitude': 11.514121
      },
      {
        'id': 4,
        'name': 'Sondi Manga',
        'adress': 'Melen, Yaoundé',
        'latitude': 3.870125,
        'longitude': 11.508654
      },
      {
        'id': 5,
        'name': 'Malina Jenevièvre',
        'adress': 'Oyomabang, Yaoundé',
        'latitude': 3.877784,
        'longitude': 11.519412
      },
      {
        'id': 6,
        'name': 'Françoise Alexandra',
        'adress': 'Oyomabang, Yaoundé',
        'latitude': 3.8812532,
        'longitude': 11.5204521
      },
      {
        'id': 7,
        'name': 'Mbono Juliette',
        'adress': 'Emombo, Yaoundé',
        'latitude': 3.8710451,
        'longitude': 11.520121
      },
      {
        'id': 8,
        'name': 'Monlo Manga',
        'adress': 'Cite verte, Yaoundé',
        'latitude': 3.8717125,
        'longitude': 11.509654
      },
      {
        'id': 9,
        'name': 'Marina Koslova',
        'adress': 'Ekounou, Yaoundé',
        'latitude': 3.8722684,
        'longitude': 11.516012
      },
    ];

    return Scaffold(
      key: drawerKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: AppBarContent(
          title: 'Accueil',
          onPressBtnMenu: () {
            drawerKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
          elevation: 0,
          child: HomeDrawer()
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        height: screenHeight,
        decoration: const BoxDecoration(
          color: backgroundColor1,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(29), topRight: Radius.circular(29))
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              children: clientsInfos.map(
                (clientInfo) => ClientPresentItem(
                  imageUrl: 'assets/images/asset1.jpg',
                  address: clientInfo['adress']!,
                  name: clientInfo['name']!,
                )
              ).toList(),
            ),
          ),
        )
      ),
    );
  }
}
