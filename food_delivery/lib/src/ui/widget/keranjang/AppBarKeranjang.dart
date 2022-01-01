import 'package:flutter/material.dart';
import 'package:food_delivery/src/utility/constants.dart';

AppBar AppBarKeranjang({
  BuildContext context,
  VoidCallback getTotalItem,
}) {
  return AppBar(
    backgroundColor: colorTeal,
    elevation: 0.0,
    title: Text(
      'Keranjang',
      style: TextStyle(
        fontFamily: 'Varela',
      ),
    ),
    leading: IconButton(
      icon: Icon(
        Icons.chevron_left,
      ),
      onPressed: () {
        Navigator.pop(context);
        getTotalItem();
      },
    ),
    actions: [],
  );
}
