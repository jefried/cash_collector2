import 'package:flutter/material.dart';

class PhotosAccount extends StatelessWidget {
  const PhotosAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 176,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("assets/details_compte/photo_indisponible.jpg",),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFBEBEBE),
                        blurRadius: 2.0,
                        offset: Offset(0,3),
                      )
                    ]
                ),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: Container(
                          color: Colors.black.withOpacity(0.6),
                          child: Text("Photo du lieu", style: TextStyle(color: Colors.white, fontSize: 17),),
                        )
                    ),
                  ],
                )
            ),
            const SizedBox(height: 10,),
            Container(
                height: 176,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("assets/details_compte/photo_indisponible.jpg"),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFBEBEBE),
                        blurRadius: 2.0,
                        offset: Offset(0,3),
                      )
                    ]
                ),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: Container(
                          color: Colors.black.withOpacity(0.6),
                          child: Text("Photo CNI (recto)", style: TextStyle(color: Colors.white, fontSize: 17),),
                        )
                    ),
                  ],
                )
            ),
            const SizedBox(height: 10,),
            Container(
                height: 176,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage("assets/details_compte/photo_indisponible.jpg"),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFFBEBEBE),
                        blurRadius: 2.0,
                        offset: Offset(0,3),
                      )
                    ]
                ),
                child: Stack(
                  children: [
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: Container(
                          color: Colors.black.withOpacity(0.6),
                          child: Text("Photo CNI (verso)", style: TextStyle(color: Colors.white, fontSize: 17),),
                        )
                    ),
                  ],
                )
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
