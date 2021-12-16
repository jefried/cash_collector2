import 'package:cash_collector/composants/circular_button.dart';
import 'package:flutter/material.dart';

class BlockSelected extends StatefulWidget {
  const BlockSelected({Key? key, this.texte = "Lundi", this.width = 80}) : super(key: key);
  final String texte;
  final double width;
  @override
  BlockSelectedState createState() => BlockSelectedState();
}

class BlockSelectedState extends State<BlockSelected> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          check = !check;
        });
      },
      child: SizedBox(
        height: 36,
        width: widget.width + 14,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: _box(),
            ),
            check?Positioned(
              top: 0,
              right: 0,
              child: CircleAvatar(
                radius: 11,
                backgroundColor: Colors.white,
                child: CircularButton(icon: Icons.check_circle_outline,sizeIcon: 16, size: 36, foregroundColor: const Color(0xFF35CC3F),),
              ),
            ):const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _box() {
    return Container(
      height: 36,
      width: widget.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFBEBEBE),
              blurRadius: 6,
              offset: Offset(0,3),
            )
          ]
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(widget.texte, style: const TextStyle(color: Colors.black, fontSize: 15,),),
      )),
    );
  }

}