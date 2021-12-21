import 'package:badges/badges.dart';
import 'package:cash_collector/composants/switch_activity_state.dart';
import 'package:cash_collector/helpers/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cash_collector/pages/notifications.dart' as notif;

class AppBarContent extends StatefulWidget {
  final Function onPressBtnMenu;
  final String title;
  final IconData icon;
  final bool leading = true;
  const AppBarContent({
    Key? key,
    required this.onPressBtnMenu,
    required this.title,
    this.icon = Icons.menu_rounded
  }) : super(key: key);

  @override
  _AppBarContentState createState() => _AppBarContentState();
}

class _AppBarContentState extends State<AppBarContent> {

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: widget.leading? IconButton(
        icon: Icon(
          widget.icon,
          color: secondaryColor,
        ),
        onPressed: () {
          widget.onPressBtnMenu();
        },
      ): IconButton(
        icon: Icon(
          widget.icon,
          color: Colors.transparent,
        ),
        onPressed: () {},
      ),
      backgroundColor: Colors.white,
      // centerTitle: true,
      title: Row(
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                fontFamily: 'Poppins Regular',
                fontSize: 18,
                color: secondaryColor
            ),
          ),
        ],
      ),
      actions: [
        const SwitchActivity(),
        Badge(
          child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const notif.Notification()));
              },
              icon: const Icon(
                Icons.notifications_outlined,
                color: infosColor1,
                size: 30,
              )
          ),
          position: BadgePosition(
              top: 4,
              end: 8
          ),
          badgeContent: Text(
            '1',
            style: TextStyle(
                color: Colors.white,
                fontSize: 10
            ),
          ),
        ),
      ],
    );
  }
}
