import 'package:flutter/material.dart';
import 'package:food_delivery/src/utility/constants.dart';

AppBar AppBarMaps({BuildContext context}) {
  return AppBar(
    backgroundColor: colorTeal,
    elevation: 0.0,
    title: Text(
      'Pilih Lokasi',
      style: TextStyle(
        fontFamily: 'Varela',
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.chevron_left,
        size: 32,
      ),
    ),
  );
}
