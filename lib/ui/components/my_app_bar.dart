import 'package:e_ticaret_app/ui/screens/notification_screen.dart';
import 'package:e_ticaret_app/ui/screens/order_screen.dart';
import 'package:e_ticaret_app/ui/tools/app_color.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  MyAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_bag, color: textColor2),
          ),
          Text(
            title,
            style: TextStyle(
              color: textColor2,
              fontSize: 26,
              fontFamily: "PlayWriteHU",
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
            icon: Icon(Icons.notifications_rounded, color: textColor2),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderScreen()),
              );
            },
            icon: Icon(Icons.local_grocery_store_rounded, color: textColor2),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: mainColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50); //kToolbarHeight
}
