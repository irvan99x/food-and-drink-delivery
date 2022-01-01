import 'package:flutter/material.dart';
import 'package:food_delivery/src/utility/constants.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: colorTeal,
    elevation: 5,
    title: Text(
      'Transaksi Pemesanan',
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
        size: 32.0,
      ),
    ),
  );
}
