import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClientsListItem extends StatelessWidget {
  final String name;
  final String job;
  final String phoneNumber;
  final String address;
  final String imagePath;
  const ClientsListItem({
    Key? key,
    required this.name,
    required this.job,
    required this.phoneNumber,
    required this.address,
    required this.imagePath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      height: 108,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow:  [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.29),
            offset: const Offset(3, 3),
            blurRadius: 9
          )
        ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
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
          const SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Poppins Medium',
                  fontSize: 13.5,
                  color: colorText1
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.work,
                    color: infosColor1,
                    size: 18,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: screenWidth - 190,
                    child: Text(
                      job,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: infosColor1,
                        fontSize: 11,
                        fontFamily: 'Poppins Light'
                      )
                    ),
                  )
                ],
              ),
              // const SizedBox(
              //   height: 2,
              // ),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: infosColor1,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: infosColor1,
                      fontSize: 11,
                      fontFamily: 'Poppins Light'
                    )
                  )
                ],
              ),
              // const SizedBox(
              //   height: 2,
              // ),
              Row(
                children: [
                  const Icon(
                    Icons.place,
                    color: infosColor1,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: screenWidth - 190,
                    child: Text(
                      address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: infosColor1,
                        fontSize: 11,
                        fontFamily: 'Poppins Light'
                      )
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
