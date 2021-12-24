import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/pages/encaissement.dart';
import 'package:cash_collector/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ClientPresentItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String address;

  const ClientPresentItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.address
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          width: screenWidth/2 - 25,
          // height: 220,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.29),
                    blurRadius: 6,
                    offset: const Offset(0, 3)
                )
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover
                    ),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(14), topLeft: Radius.circular(14))
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Text(
                  name,
                  style: const TextStyle(
                      fontFamily: 'Poppins Medium',
                      fontSize: 13,
                      color: colorText1
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: infosColor1,
                    ),
                    SizedBox(
                      width: screenWidth / 2 - 67,
                      child: Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Poppins Light',
                            fontSize: 11,
                            color: infosColor1
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
          )
        ),
        Positioned(
          top: 18,
          right: 18,
          child: PopupMenuButton(
            child: Container(
              width: 25,
              height: 25,
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
                Icons.more_vert,
                size: 20,
                color: colorText1,
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text(
                  'Voir sur la map',
                  style: TextStyle(
                      fontFamily: 'Poppins Light',
                      fontSize: 10,
                      color: infosColor1
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext ctx) => Home())
                  );
                },
              ),
              PopupMenuItem(
                child: Text(
                  'Encaisser',
                  style: TextStyle(
                    fontFamily: 'Poppins Light',
                    fontSize: 10,
                    color: infosColor1
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Encaissement(noms: name)));
                },
              )
            ]
          )
        ),
      ]
    );
  }
}
