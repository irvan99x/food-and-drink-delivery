import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/src/utility/constants.dart';

AppBar AppBarDetail({
  BuildContext context,
  int totalItem,
  String id_pelanggan,
  bool isLogin,
  VoidCallback getTotalItem,
  VoidCallback getTotalItemHome,
}) {
  return AppBar(
    backgroundColor: colorTeal,
    elevation: 0.0,
    leading: IconButton(
      icon: Icon(
        Icons.chevron_left,
      ),
      onPressed: () {
        Navigator.pop(context);
        getTotalItemHome();
      },
    ),
    actions: [
      Badge(
        badgeContent: Text(
          '$totalItem',
          style: TextStyle(
            color: Colors.black,
            fontSize: 10.0,
          ),
        ),
        showBadge: totalItem == 0 ? false : true,
        position: BadgePosition.bottomEnd(
          bottom: 5.0,
          end: 4.0,
        ),
        badgeColor: Colors.white,
        toAnimate: true,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        animationType: BadgeAnimationType.scale,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
      )
    ],
  );
}
