import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({Key? key, this.icon=Icons.person, this.sizeIcon = 20, this.backgroundColor = const Color(0xFFFFFFFF), this.foregroundColor = const Color(0xFF075BD5), this.colorShadow = const Color(0xFFBEBEBE), this.size= 36}) : super(key: key);
  final IconData icon;
  final double sizeIcon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color colorShadow;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size/2),
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: colorShadow,
              blurRadius: 7,
              offset: const Offset(0,3),
            )
          ]
      ),
      child: Center(
          child: Icon(icon, size: sizeIcon, color: foregroundColor,)
      ),
    );
  }

}