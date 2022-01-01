import 'package:flutter/material.dart';

class StatusPesanan extends StatelessWidget {
  final String status;

  const StatusPesanan({
    Key key,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String isStatus;
    Color statusColor;
    IconData statusIcon;

    if (status == '0') {
      isStatus = 'Pesanan dibatalkan';
      statusColor = Colors.red;
      statusIcon = Icons.cancel;
    } else if (status == '1') {
      isStatus = 'Pesanan belum diproses';
      statusColor = Colors.red;
      statusIcon = Icons.assignment_late;
    } else if (status == '2') {
      isStatus = 'Pesanan sementara diproses';
      statusColor = Colors.blue;
      statusIcon = Icons.sync;
    } else if (status == '3') {
      isStatus = 'Pesanan dalam perjalanan';
      statusColor = Colors.lightBlueAccent;
      statusIcon = Icons.motorcycle;
    } else {
      isStatus = 'Pesanan Selesai';
      statusColor = Colors.green;
      statusIcon = Icons.assignment_turned_in;
    }

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
            'STATUS PESANAN',
            style: TextStyle(fontFamily: 'Varela', fontSize: 12.0),
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
                  statusIcon,
                  color: statusColor,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: Text(
                    '$isStatus',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      color: statusColor,
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
