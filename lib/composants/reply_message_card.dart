import 'package:flutter/material.dart';

class ReplyMessageCard extends StatelessWidget {
  const ReplyMessageCard({Key? key, required this.message, required this.date}) : super(key: key);
  final String message;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 24,),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 100,
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(17, 17, 17, 10),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: <Color>[
                              Color(0xFF5095FB),
                              Color(0xFF060DD9),
                            ], // red to yellow
                            tileMode: TileMode.repeated, // repeats the gradient over the canvas
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(17),
                            bottomRight: Radius.circular(17),
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(message, style: TextStyle(color: Colors.white,fontSize: 15), overflow: TextOverflow.clip,),
                          SizedBox(height: 5,),
                          Text(date, style: TextStyle(color: Colors.white, fontSize: 12),)
                        ],
                      ),

                    ),
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }

}