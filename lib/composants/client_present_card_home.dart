import 'package:cash_collector/helpers/colors.dart';
import 'package:cash_collector/pages/encaissement.dart';
import 'package:flutter/material.dart';

class ClientPresentCardHome extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String address;
  final VoidCallback onPress;
  final bool isClicked;

  const ClientPresentCardHome({
    Key? key,
    required this.imageUrl,
    required this.address,
    required this.name,
    required this.onPress,
    required this.isClicked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onPress,
      child: Container(
        width: 160,
        // height: 220,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
            border: isClicked ? Border.all(
                color: secondaryColor,
                width: 2
            ) : null,
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
              height: 100,
              width: 160,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover
                  ),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(14), topLeft: Radius.circular(14))
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                name,
                style: const TextStyle(
                    fontFamily: 'Poppins Medium',
                    fontSize: 13,
                    color: namePresentColor
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 20,
                    color: infosColor1,
                  ),
                  SizedBox(
                    width: 115,
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
            ),
            Container(
              width: double.infinity,
              height: 30,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                      colors: [
                        secondaryColor,
                        principalColor
                      ]
                  )
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Encaissement(noms: name)));
                },
                child: const Text(
                  'Encaisser',
                  style: TextStyle(
                      fontFamily: 'Poppins Medium',
                      fontSize: 11,
                      color: Colors.white
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

