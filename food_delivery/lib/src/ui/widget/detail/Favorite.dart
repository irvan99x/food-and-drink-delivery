import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.0,
      height: 32.0,
      child: Icon(
        Icons.favorite_border,
        color: Colors.red[600],
        size: 32.0,
      ),
    );
  }
}
