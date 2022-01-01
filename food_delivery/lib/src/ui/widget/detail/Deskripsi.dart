import 'package:flutter/material.dart';

class Deskripsi extends StatelessWidget {
  final String deskripsi;

  Deskripsi({this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5.0,
        bottom: 10.0,
      ),
      child: Text(
        '$deskripsi',
        style:
            TextStyle(height: 1.5, fontFamily: 'Varela', color: Colors.black),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
