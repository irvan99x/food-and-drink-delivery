import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/TransaksiBloc.dart';
import 'package:food_delivery/src/model/TransaksiModel.dart';
import 'package:food_delivery/src/ui/widget/transaksi/AppBarTransaksi.dart';
import 'package:food_delivery/src/ui/widget/transaksi/TransaksiItem.dart';
import 'package:food_delivery/src/utility/constants.dart';

class Transaksi extends StatefulWidget {
  final String id_pelanggan;

  const Transaksi({
    Key key,
    this.id_pelanggan,
  }) : super(key: key);

  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transaksiBloc.getTransaksi(widget.id_pelanggan);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    transaksiBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
            stream: transaksiBloc.countTransaksi,
            builder: (context, AsyncSnapshot<List<TransaksiModel>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak Ada Transaksi',
                    ),
                  );
                } else {
                  return TransaksiItem(
                    context: context,
                    snapshot: snapshot,
                  );
                }
              } else if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(colorTeal),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
