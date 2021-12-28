import 'package:cash_collector/composants/app_bar_content.dart';
import 'package:cash_collector/composants/block_button.dart';
import 'package:cash_collector/composants/home_drawer.dart';
import 'package:cash_collector/composants/notif.dart';
import 'package:cash_collector/style/colors.dart';
import 'package:flutter/material.dart';

class Notification extends StatefulWidget {
  const Notification({Key? key}) : super(key: key);

  @override
  NotificationState createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      drawer:Drawer(
          elevation: 0,
          child: HomeDrawer()
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(57),
        child: AppBarContent(
          noti: false,
          title: "Notifications",
          onPressBtnMenu: (){
            drawerKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 72,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
            color: Color(0xFFF3F3FF),
            borderRadius: BorderRadius.only(topRight: Radius.circular(29), topLeft: Radius.circular(29))
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Expanded(child: SizedBox(),),
                BlockButton(text: "Effacer", foregroundColor: Colors.black, backgroundColor: Colors.white, bold: false, shadow: true, colorShadow: textColorGreyAccent,),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
                    Notif(),
                    Notif(),
                    Notif(),
                    Notif(),
                    Notif(),
                    Notif(),
                    Notif(),
                    Notif(),
                    Notif(),
                    Notif(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}