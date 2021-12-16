import 'package:cash_collector/composants/appbar_content_with_back.dart';
import 'package:cash_collector/composants/client_list_item.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/pages/creation_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientList extends StatefulWidget {
  const ClientList({Key? key}) : super(key: key);

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {

  List<Map<String, String>> clientsInfos = [
    {
      'name': 'Sondi Manga',
      'job': 'Livreur',
      'adress': 'Melen, Yaoundé',
      'phone': '+237 655 222 678'
    },
    {
      'name': 'Malina Jenevièvre',
      'job': 'Commerçante',
      'adress': 'Oyomabang, Yaoundé',
      'phone': '+237 655 789 678'
    },
    {
      'name': 'Lili goumette',
      'job': 'Livreur',
      'adress': 'Melen, Yaoundé',
      'phone': '+237 655 222 678'
    },
    {
      'name': 'Sondi Manga',
      'job': 'Livreur',
      'adress': 'Melen, Yaoundé',
      'phone': '+237 655 222 678'
    },
    {
      'name': 'Malina Jenevièvre',
      'job': 'Commerçante',
      'adress': 'Oyomabang, Yaoundé',
      'phone': '+237 655 789 678'
    },
  ];

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: AppBarContentWithBack(
          title: 'Clients',
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF3F3FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(29),
            topRight: Radius.circular(29)
          )
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(23),
                            borderSide: const BorderSide(
                              color: infosColor1,
                              width: 0.2
                            )
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: shadowColor1,
                            size: 24,
                          ),
                          hintText: 'Rechercher un client',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins Light',
                            fontSize: 15,
                            color: shadowColor1
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'Poppins Light',
                          fontSize: 15,
                          color: shadowColor2
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: MaterialButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                              color: infosColor1,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Filtre',
                                style: TextStyle(
                                    fontFamily: 'Poppins Light',
                                    fontSize: 13,
                                    color: Colors.white
                                ),
                              ),
                              Icon(
                                Icons.filter_list_rounded,
                                color: Colors.white,
                                size: 20,
                              )
                            ],
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: screenHeight - 150,
                child: ListView(
                  children: clientsInfos.map(
                    (clientInfos) => ClientsListItem(
                      name: clientInfos['name']!,
                      job: clientInfos['job']!,
                      phoneNumber: clientInfos['phone']!,
                      address: clientInfos['adress']!,
                      imagePath: 'assets/images/asset1.jpg'
                    )
                  ).toList()
                ),
              )
            )
          ],
        ),
      ),
      floatingActionButton: MaterialButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreationClient()));
        },
        textColor: Colors.white,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                secondaryColor,
                principalColor
              ]
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: shadowColor2.withOpacity(0.52),
                blurRadius: 16,
                offset: const Offset(0, 3)
              )
            ]
          ),

          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
        shape: CircleBorder(),
      ),
    );
  }
}
