import 'package:flutter/material.dart';

class Bayar extends StatelessWidget {
  final String payment;

  const Bayar({
    Key key,
    this.payment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 15.0,
        right: 15.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.payment,
              color: Colors.grey,
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Varela',
                    color: Colors.grey[800],
                    fontSize: 13.0,
                  ),
                  text: payment,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
