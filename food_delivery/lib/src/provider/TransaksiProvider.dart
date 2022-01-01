import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:food_delivery/src/model/LogPemesananModel.dart';
import 'package:food_delivery/src/model/TransaksiModel.dart';
import 'package:food_delivery/src/utility/BaseURL.dart';
import 'package:http/http.dart' show Client;

class TransaksiProvider {
  Client client = Client();

  Future<dynamic> getTotalBayar(String id_pelanggan) async {
    var uri = Uri.parse(BaseURL.urlGetTotalBayar);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'application/json',
    });

    return jsonDecode(res.body);
  }

  Future<dynamic> kirimPesanan(Map<String, String> data) async {
    var uri = Uri.parse(BaseURL.urlKirimPesanan);

    final res = await client.post(uri, headers: {
      'Accept': 'application/json',
    }, body: {
      'total_bayar': data['total_bayar'],
      'alamat_kirim': data['alamat_kirim'],
      'latitude': data['latitude'],
      'longitude': data['longitude'],
      'id_pelanggan': data['id_pelanggan'],
      'note': data['note'],
      'payment': data['payment'],
      'ongkir': data['ongkir'],
    });

    return jsonDecode(res.body);
  }

  Future<List<TransaksiModel>> getTransaksi(String id_pelanggan) async {
    var uri = Uri.parse(BaseURL.urlGetTransaksi);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'application/json',
    });
    if (res.statusCode == 200) {
      return compute(
        transaksiFromJson,
        res.body,
      );
    }

    return [];
  }

  Future<List<LogPemesananModel>> getItemTransaksi(
    String kd_pemesanan,
    String id_pelanggan,
  ) async {
    var uri = Uri.parse(BaseURL.urlGetItemTransaksi);

    uri = uri.replace(queryParameters: <String, String>{
      'kd_pemesanan': kd_pemesanan,
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'application/json',
    });
    if (res.statusCode == 200) {
      return compute(
        logFromJson,
        res.body,
      );
    }

    return [];
  }
}
