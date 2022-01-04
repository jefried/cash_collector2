import 'package:badges/badges.dart';
import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/client_present_card_home.dart';
import 'package:cash_collector/composants/home_drawer.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/helpers/map_displayer.dart';
import 'package:cash_collector/pages/home_clients_list.dart';
import 'package:flutter/material.dart';
import 'package:here_sdk/mapview.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  MapDisplayer? mapDisplayer;
  int selectedClientId = 0;
  late Position _currentPositon;
  List<Map<String, dynamic>> clientsInfos = [
    {
      'id': 1,
      'name': 'Sondi Manga',
      'adress': 'Melen, Yaoundé',
      'latitude': 3.8624,
      'longitude': 11.5,
      'imgPath': 'assets/images/asset1.jpg'
    },
    {
      'id': 2,
      'name': 'Malina Jenevièvre',
      'adress': 'Oyomabang, Yaoundé',
      'latitude': 3.8608627,
      'longitude': 11.5098449,
      'imgPath': 'assets/details_compte/profil.jpg'
    },
    {
      'id': 3,
      'name': 'Lili goumette',
      'adress': 'Melen, Yaoundé',
      'latitude': 3.8857832,
      'longitude': 11.5457261,
      'imgPath': 'assets/images/asset1.jpg'
    },
    {
      'id': 4,
      'name': 'Sondi Manga',
      'adress': 'Melen, Yaoundé',
      'latitude': 3.8482683,
      'longitude': 11.5647734,
      'imgPath': 'assets/details_compte/profil.jpg'

    },
    {
      'id': 5,
      'name': 'Malina Jenevièvre',
      'adress': 'Oyomabang, Yaoundé',
      'latitude': 3.868103,
      'longitude': 11.500214,
      'imgPath': 'assets/details_compte/profil.jpg'
    },
  ];


  void _onMapCreated(HereMapController hereMapController)  {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay, (MapError? error) async {
      if (error == null) {
        _currentPositon = await _geolocatorPlatform.getCurrentPosition();
        mapDisplayer = MapDisplayer(hereMapController, clientsInfos, context, _currentPositon);
      } else {
        print("Map scene not loaded. MapError: " + error.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

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
      body: Stack(
          children: [
            HereMap(
              onMapCreated: _onMapCreated,
            ),
            Positioned(
                bottom: 320,
                right: 20,
                child: InkWell(
                  onTap: (){},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: shadowColor1,
                              offset: Offset(0, 3),
                              blurRadius: 16
                          )
                        ],
                        shape: BoxShape.circle
                    ),
                    child: const Icon(
                      Icons.gps_fixed_rounded,
                      size: 30,
                      color: colorText1,
                    ),
                  ),
                )
            ),
            Positioned(
              bottom: 230,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.65),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext ctx) => HomeClientsList())
                    );
                  },
                  child: Row(
                      children: [
                        Text(
                          'Voir Tout',
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins Medium',
                            color: secondaryColor,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          color: principalColor,
                          size: 24,
                        )
                      ]
                  )
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              height: 230,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: clientsInfos.map(
                  (clientInfo) => ClientPresentCardHome(
                    imageUrl: clientInfo['imgPath'],
                    address: clientInfo['adress']!,
                    name: clientInfo['name']!,
                    isClicked: clientInfo['id'] == selectedClientId,
                    onPress: () {
                      mapDisplayer?.setClientAsSelected(
                        clientInfo['id'],
                        clientInfo['imgPath'],
                        clientInfo['adress']!,
                        clientInfo['name']
                      );
                      setState(() {
                        selectedClientId = clientInfo['id'];
                      });
                    }
                  ),
                ).toList()
              )
            )
          )
        ]
      )
      );
    }
  }



