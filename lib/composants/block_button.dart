import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {
  const BlockButton({Key? key, this.text='', this.linear = false, this.linearColor1 = const Color(0xFFC24644), this.linearColor2 = const Color(0xFF8F1716), this.backgroundColor = const Color(0xFFFFFFFF), this.foregroundColor = const Color(0xFF075BD5), this.colorShadow = const Color(0xFFBEBEBE), this.shadow = false, this.bold = true,}):super(key: key);
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool shadow;
  final bool linear;
  final Color linearColor1;
  final Color linearColor2;
  final Color colorShadow;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
          gradient: linear?LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              linearColor1,
              linearColor2,
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ):null,
          borderRadius: BorderRadius.circular(18),
          color: backgroundColor,
          boxShadow: [
            shadow?BoxShadow(
              color: colorShadow,
              blurRadius: 7,
              offset: const Offset(0,3),
            ): const BoxShadow()
          ]
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(text, style: TextStyle(color: foregroundColor, fontSize: 15, fontWeight: bold?FontWeight.bold: FontWeight.normal),),
      )),
    );
  }

}