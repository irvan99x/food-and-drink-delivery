import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/TransaksiBloc.dart';
import 'package:food_delivery/src/ui/main/MainNavigation.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/Alamat.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/AppBar.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/Bayar.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/Catatan.dart';
import 'package:food_delivery/src/ui/widget/pemesanan/ListPesanan.dart';
import 'package:food_delivery/src/utility/SessionManager.dart';
import 'package:food_delivery/src/utility/ShowToast.dart';
import 'package:food_delivery/src/utility/constants.dart';
import 'package:intl/intl.dart';

class Pemesanan extends StatefulWidget {
  final String id_pelanggan;

  Pemesanan({
    this.id_pelanggan,
  });

  @override
  _PemesananState createState() => _PemesananState();
}

class _PemesananState extends State<Pemesanan> {
  TextEditingController _noteController = TextEditingController();

  double lat;
  double lng;
  String alamat;
  String payment;
  int isBayar;
  int totalBayar = 0;
  int totalOngkir = 0;
  bool isKirim = false;
  bool validAlamat;
  bool validPayment;

  @override
  void initState() {
    super.initState();
    _getAddress();
    _getPayment();
    _getTotalBayar();
  }

  @override
  Widget build(BuildContext context) {
    print(totalBayar);
    print(totalOngkir);
    print(alamat);

    final formatter = NumberFormat("#,###");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: !isKirim
          ? SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 60.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                            ),
                            child: Text(
                              'ALAMAT KIRIM',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Alamat(
                            alamat: alamat,
                            getAddress: _getAddress,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                            ),
                            child: Text(
                              'RINGKASAN PESANAN',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          ListPesanan(
                            id_pelanggan: widget.id_pelanggan,
                            ongkir: totalOngkir,
                            totalBayar: totalBayar,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                            ),
                            child: Text(
                              'METODE PEMBAYARAN',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Bayar(
                            payment: payment,
                            getPayment: _getPayment,
                          ),
                          Catatan(
                            noteController: _noteController,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.1,
                    left: 0.1,
                    right: 0.1,
                    child: Container(
                      height: 60.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                width: 50.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Bayar',
                                      style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(
                                      'Rp. ${formatter.format(totalBayar + totalOngkir)}',
                                      style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Material(
                            elevation: 0.0,
                            color: colorTeal,
                            borderRadius: BorderRadius.circular(5.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: () {
                                _kirimPesanan();

                                // if (!validAlamat) {
                                //   ShowToast().showToastWarning(
                                //       "Alamat kirim belum dipilih!");
                                // } else if (!validPayment) {
                                //   ShowToast().showToastWarning(
                                //       "Metode bayar belum dipilih!");
                                // } else {
                                //   _kirimPesanan();
                                // }

                                // if (!validAlamat && !validPayment) {
                                //   ShowToast().showToastWarning(
                                //       'Alamat dan Metode bayar belum dipilih');
                                // } else {
                                //   _kirimPesanan();
                                // }
                              },
                              child: Container(
                                width: 160.0,
                                child: Center(
                                  child: Text(
                                    'PESAN SEKARANG',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _getAddress() async {
    Map _result = await SessionManager().getSessionAddress();

    setState(() {
      lat = _result['latitude'];
      lng = _result['longitude'];
      alamat = _result['alamat'];
      validAlamat = _result['validAlamat'];
    });
  }

  _getPayment() async {
    Map _result = await SessionManager().getSessionPayment();

    setState(() {
      payment = _result['payment'];
      validPayment = _result['validPayment'];
    });
  }

  _getTotalBayar() async {
    final data = await transaksiBloc.getTotalBayar(widget.id_pelanggan);

    if (data['status']) {
      setState(() {
        totalBayar = data['data']['totalBayar'];
        totalOngkir = data['data']['totalOngkir'];
      });
    } else {
      print(data['message']);
    }
  }

  _kirimPesanan() async {
    setState(() {
      isKirim = true;
    });

    Map<String, String> data = {
      'total_bayar': (totalBayar + totalOngkir).toString(),
      'alamat_kirim': alamat,
      'latitude': lat.toString(),
      'longitude': lng.toString(),
      'id_pelanggan': widget.id_pelanggan,
      'note': _noteController.text,
      'payment': payment,
      'ongkir': totalOngkir.toString(),
    };

    final result = await transaksiBloc.kirimPesanan(data);

    if (result['status']) {
      setState(() {
        isKirim = false;
      });

      SessionManager().removeSessionPayment();
      ShowToast().showToastSuccess(result['message']);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigation(),
        ),
        (route) => false,
      );
    } else {
      setState(() {
        isKirim = false;
      });

      ShowToast().showToastError(result['message']);
    }
  }
}
