import 'package:flutter/material.dart';

SizedBox CartCounter({
  IconData icon,
  Color color,
  Function press,
}) {
  return SizedBox(
    width: 40.0,
    height: 32.0,
    child: OutlineButton(
      padding: EdgeInsets.zero,
      hoverColor: color,
      highlightedBorderColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      onPressed: press,
      child: Icon(
        icon,
        color: color,
      ),
    ),
  );
}
