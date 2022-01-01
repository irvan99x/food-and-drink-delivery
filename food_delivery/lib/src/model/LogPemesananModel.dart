import 'dart:convert';

List<LogPemesananModel> logFromJson(String str) {
  final jsonData = json.decode(str);
  return List<LogPemesananModel>.from(
      jsonData.map((x) => LogPemesananModel.fromJson(x)));
}

class LogPemesananModel {
  String id;
  String nama_produk;
  String harga;
  String qty;
  String total;

  LogPemesananModel({
    this.id,
    this.nama_produk,
    this.harga,
    this.qty,
    this.total,
  });

  factory LogPemesananModel.fromJson(Map<String, dynamic> json) =>
      LogPemesananModel(
        id: json['id'],
        nama_produk: json['nama_produk'],
        harga: json['harga'],
        qty: json['qty'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_produk': nama_produk,
        'harga': harga,
        'qty': qty,
        'total': total,
      };
}
