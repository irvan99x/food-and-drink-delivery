import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:food_delivery/src/model/KeranjangModel.dart';
import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:http/http.dart' show Client;

class KeranjangProvider {
  Client client = Client();

  Future<List<KeranjangModel>> getKeranjang(String id_pelanggan) async {
    var uri = Uri.parse(BaseURL.urlGetKeranjang);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'application/json',
    });

    if (res.statusCode == 200) {
      return compute(keranjangFromJson, res.body);
    } else {
      return [];
    }
  }

  Future<dynamic> tambahKeranjang(Map<String, String> data) async {
    final res = await client.post(
        Uri.parse(
          BaseURL.urlTambahKeranjang,
        ),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'nama_produk': data['nama_produk'],
          'harga': data['harga'],
          'qty': data['qty'],
          'gambar': data['gambar'],
          'id_pelanggan': data['id_pelanggan'],
        });

    return jsonDecode(res.body);
  }

  Future<dynamic> ubahQtyKeranjang(Map<String, String> data) async {
    final res = await client.post(
        Uri.parse(
          BaseURL.urlUbahQtyKeranjang,
        ),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'id': data['id'],
          'qty': data['qty'],
        });

    return jsonDecode(res.body);
  }

  Future<dynamic> hapusItemKeranjang(String id) async {
    var uri = Uri.parse(BaseURL.urlHapusItemKeranjang);

    uri = uri.replace(queryParameters: <String, String>{
      'id': id,
    });
    final res = await client.delete(
      uri,
      headers: {
        'Accept': 'application/json',
      },
    );

    return jsonDecode(res.body);
  }

  Future<dynamic> getTotalItem(
    String id_pelanggan,
  ) async {
    var uri = Uri.parse(BaseURL.urlGetTotalItem);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(
      uri,
      headers: {
        'Accept': 'application/json',
      },
    );

    return jsonDecode(res.body);
  }
}
