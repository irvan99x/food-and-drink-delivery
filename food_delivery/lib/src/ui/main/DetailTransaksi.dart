import 'package:flutter/material.dart';
import 'package:food_delivery/src/ui/widget/detail_transaksi/Alamat.dart';
import 'package:food_delivery/src/ui/widget/detail_transaksi/AppBar.dart';
import 'package:food_delivery/src/ui/widget/detail_transaksi/Bayar.dart';
import 'package:food_delivery/src/ui/widget/detail_transaksi/Catatan.dart';
import 'package:food_delivery/src/ui/widget/detail_transaksi/CatatanPembatalan.dart';
import 'package:food_delivery/src/ui/widget/detail_transaksi/ListPesanan.dart';
import 'package:food_delivery/src/ui/widget/detail_transaksi/StatusPesanan.dart';
import 'package:intl/intl.dart';

class DetailTransaksi extends StatefulWidget {
  final String kd_pemesanan;
  final String tgl_pesan;
  final String total_bayar;
  final String alamat_kirim;
  final String status;
  final String noteCancel;
  final String note;
  final String payment;
  final String ongkir;
  final String id_pelanggan;

  const DetailTransaksi({
    Key key,
    this.kd_pemesanan,
    this.tgl_pesan,
    this.total_bayar,
    this.alamat_kirim,
    this.status,
    this.noteCancel,
    this.note,
    this.payment,
    this.ongkir,
    this.id_pelanggan,
  }) : super(key: key);

  @override
  _DetailTransaksiState createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SafeArea(
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
                    StatusPesanan(
                      status: widget.status,
                    ),
                    if (widget.status == '0')
                      CatatanPembatalan(
                        noteCancel: widget.noteCancel,
                      ),
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
                      alamat: widget.alamat_kirim,
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
                      kd_pemesanan: widget.kd_pemesanan,
                      id_pelanggan: widget.id_pelanggan,
                      ongkir: int.parse(widget.ongkir),
                      totalBayar: int.parse(widget.total_bayar),
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
                      payment: widget.payment,
                    ),
                    Catatan(
                      note: widget.note,
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
                                'Rp. ${formatter.format(int.parse(widget.total_bayar))}',
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
