import 'package:flutter/material.dart';
import 'package:food_delivery/src/bloc/KeranjangBloc.dart';
import 'package:food_delivery/src/ui/main/Login.dart';
import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:food_delivery/src/utility/ShowToast.dart';
import 'package:food_delivery/src/utility/constants.dart';
import 'package:intl/intl.dart';

class ListProduk extends StatefulWidget {
  final String nama_produk;
  final String harga;
  final String gambar;
  final bool isFavorite;
  final String id_pelanggan;
  final bool isLogin;
  final VoidCallback getTotalItem;

  ListProduk({
    this.nama_produk,
    this.harga,
    this.gambar,
    this.isFavorite,
    this.id_pelanggan,
    this.isLogin,
    this.getTotalItem,
  });

  @override
  _ListProdukState createState() => _ListProdukState();
}

class _ListProdukState extends State<ListProduk> {
  final formatter = NumberFormat("#,###");

  int numQty = 1;
  int max;
  int min;
  bool add = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 5.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            )
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.nama_produk,
                  child: Container(
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          BaseURL.baseURLImg + widget.gambar,
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (widget.isFavorite)
                        Icon(
                          Icons.favorite,
                          color: Colors.red[600],
                        )
                      else
                        Icon(
                          Icons.favorite_border,
                          color: Colors.red[600],
                        )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 6.0,
                right: 6.0,
              ),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Varela',
                    color: colorTeal,
                  ),
                  text: '${widget.nama_produk}',
                ),
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Text(
              'Rp. ${formatter.format(int.parse(widget.harga))}',
              style: TextStyle(
                fontFamily: 'Varela',
                color: colorTeal,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                color: Color(0xFFEBEBEB),
                height: 1.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: _buildButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    if (!add) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                add = true;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.shopping_basket,
                  size: 18.0,
                  color: Color(0xFFD17E50),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    color: Color(0xFFD17E50),
                    fontFamily: 'Varela',
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (numQty > 1) {
                setState(() {
                  numQty--;
                });
              }
            },
            child: Icon(
              Icons.remove_circle,
              color: Colors.red[600],
              size: 20.0,
            ),
          ),
          Text(
            '${numQty.toString()}',
            style: TextStyle(
              color: Color(0xFFD17E50),
              fontFamily: 'Varela',
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                numQty++;
              });
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.green[600],
              size: 20.0,
            ),
          ),
          InkWell(
            onTap: () {
              if (!widget.isLogin) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              } else {
                _tambahKeranjang();
              }
            },
            child: Icon(
              Icons.check,
              color: Colors.green[600],
              size: 20.0,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                add = false;
              });
            },
            child: Icon(
              Icons.close,
              color: Colors.red[600],
              size: 20.0,
            ),
          )
        ],
      );
    }
  }

  _tambahKeranjang() async {
    Map<String, String> data = {
      'nama_produk': widget.nama_produk,
      'harga': widget.harga.toString(),
      'qty': numQty.toString(),
      'gambar': widget.gambar,
      'id_pelanggan': widget.id_pelanggan,
    };

    final res = await keranjangBloc.tambahKeranjang(data);

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      print(message);

      setState(() {
        add = false;
      });

      widget.getTotalItem();

      ShowToast().showToastSuccess(message);
    } else {
      print(message);

      ShowToast().showToastSuccess(message);
    }
  }
}
