import 'package:flutter/material.dart';

class CatatanPembatalan extends StatelessWidget {
  final String noteCancel;

  const CatatanPembatalan({
    Key key,
    this.noteCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            top: 10.0,
          ),
          child: Text(
            'CATATAN PEMBATALAN',
            style: TextStyle(
              fontFamily: 'Varela',
              fontSize: 12.0,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        Card(
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
                  Icons.event_note,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                    child: Text(
                  noteCancel == '' ? '-' : noteCancel,
                  style: TextStyle(
                    fontFamily: 'Varela',
                    color: Colors.grey[800],
                    fontSize: 13.0,
                  ),
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
