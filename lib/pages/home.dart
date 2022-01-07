import 'package:badges/badges.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/client_present_card_home.dart';
import 'package:cash_collector/composants/home_drawer.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/helpers/map_displayer.dart';
import 'package:cash_collector/pages/home_clients_list.dart';
import 'package:flutter/cupertino.dart';
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
  BottomDrawerController _controller = BottomDrawerController();
  bool bottomDrawerStateUp = true;

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

    double width = MediaQuery.of(context).size.width;

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
            BottomDrawer(
              cornerRadius: 20,
              header: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)
                  )
                ),
                child: Column(
                  children: [
                    Divider(
                      color: colorText1.withOpacity(0.4),
                      thickness: 3,
                      height: 16,
                      indent: width / 2 - 20,
                      endIndent: width / 2 - 20,
                    ),
                    Text(
                      'Liste des clients',
                      style: const TextStyle(
                        fontFamily: 'Poppins Medium',
                        fontSize: 16,
                        color: colorText1
                      ),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 5),
                        height: 35,
                        color: Colors.white,
                        child: MaterialButton(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                    ],
                  ),
                  SizedBox(
                    height: 225,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: clientsInfos.map(
                        (clientInfo) => ClientPresentCardHome(
                          imageUrl: clientInfo['imgPath'],
                          address: clientInfo['adress']!,
                          name: clientInfo['name']!,
                          isClicked: clientInfo['id'] == selectedClientId,
                          onPress: () async {
                            await mapDisplayer?.setClientAsSelected(
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
                  ),
                ],
              ),
              headerHeight: 50,
              drawerHeight: 320,
              color: Colors.white.withOpacity(0.8),
              controller: _controller,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 60,
                  spreadRadius: 5,
                  offset: const Offset(2, -6), // changes position of shadow
                ),
              ],
            ),
          //   Positioned(
          //     bottom: 230,
          //     right: 5,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(15),
          //         color: Colors.white.withOpacity(0.65),
          //       ),
          //       child: MaterialButton(
          //         onPressed: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(builder: (BuildContext ctx) => HomeClientsList())
          //           );
          //         },
          //         child: Row(
          //             children: [
          //               Text(
          //                 'Voir Tout',
          //                 style: const TextStyle(
          //                   fontSize: 13,
          //                   fontFamily: 'Poppins Medium',
          //                   color: secondaryColor,
          //                 ),
          //               ),
          //               const Icon(
          //                 Icons.keyboard_arrow_right,
          //                 color: principalColor,
          //                 size: 24,
          //               )
          //             ]
          //         )
          //     ),
          //   ),
          // ),

          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   left: 0,
          //   child: SizedBox(
          //     height: 230,
          //     child: ListView(
          //       scrollDirection: Axis.horizontal,
          //       children: clientsInfos.map(
          //         (clientInfo) => ClientPresentCardHome(
          //           imageUrl: clientInfo['imgPath'],
          //           address: clientInfo['adress']!,
          //           name: clientInfo['name']!,
          //           isClicked: clientInfo['id'] == selectedClientId,
          //           onPress: () async {
          //             await mapDisplayer?.setClientAsSelected(
          //               clientInfo['id'],
          //               clientInfo['imgPath'],
          //               clientInfo['adress']!,
          //               clientInfo['name']
          //             );
          //             setState(() {
          //               selectedClientId = clientInfo['id'];
          //             });
          //           }
          //         ),
          //       ).toList()
          //     )
          //   )
          // )
        ]
      )
      );
    }
  }



