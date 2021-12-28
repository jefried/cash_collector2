import 'dart:io';

import 'package:cash_collector/composants/circular_button.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CardPhotoPick extends StatefulWidget {
  const CardPhotoPick({Key? key,this.width = 176, this.initialPhoto, this.fonc}) : super(key: key);
  final double width;
  final XFile? initialPhoto;
  final Function? fonc;
  @override
  CardPhotoPickState createState() => CardPhotoPickState();
}

class CardPhotoPickState extends State<CardPhotoPick> {
  XFile? photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 176,
      width: widget.width,
      decoration: (photo != null)?
      BoxDecoration(
        image: DecorationImage(image: FileImage(File(photo!.path)), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFBEBEBE),
            blurRadius: 6.0,
            offset: Offset(0,3),
          )
        ]
      ): (widget.initialPhoto != null)?
          BoxDecoration(
              image: DecorationImage(image: FileImage(File(widget.initialPhoto!.path)), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFFBEBEBE),
                  blurRadius: 6.0,
                  offset: Offset(0,3),
                )
              ]
          )
          : BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFBEBEBE),
              blurRadius: 6,
              offset: Offset(0,3),
            )
          ]
      ),
      child: Center(
        child: InkWell(
          onTap: () {
            _takePicture(ImageSource.camera);
          },
          child: const CircularButton(icon: Icons.add_a_photo, sizeIcon: 40, size: 56, foregroundColor: stepperColor, colorShadow: stepperColorAccent,),
        )
      ),
    );
  }

  Future<void> _takePicture(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if(image != null) {
      widget.fonc!(image);
      setState(() {
        photo = image;
      });
    }
  }

}