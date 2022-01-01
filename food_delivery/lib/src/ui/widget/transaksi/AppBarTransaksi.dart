import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    textTheme: TextTheme(),
    backgroundColor: Colors.white,
    brightness: Brightness.dark,
    elevation: 1,
    title: Text(
      'Transaksi',
      style: TextStyle(
        fontFamily: 'Varela',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
      ),
      textAlign: TextAlign.start,
    ),
  );
}
