import 'dart:convert';

List<KeranjangModel> keranjangFromJson(String str) {
  final jsonData = json.decode(str);
  return List<KeranjangModel>.from(
      jsonData.map((x) => KeranjangModel.fromJson(x)));
}

class KeranjangModel {
  String id;
  String nama_produk;
  String harga;
  String qty;
  String gambar;
  String id_pelanggan;

  KeranjangModel({
    this.id,
    this.nama_produk,
    this.harga,
    this.qty,
    this.gambar,
    this.id_pelanggan,
  });

  factory KeranjangModel.fromJson(Map<String, dynamic> json) => KeranjangModel(
        id: json['id'],
        nama_produk: json['nama_produk'],
        harga: json['harga'],
        qty: json['qty'],
        gambar: json['gambar'],
        id_pelanggan: json['id_pelanggan'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_produk': nama_produk,
        'harga': harga,
        'qty': qty,
        'gambar': gambar,
        'id_pelanggan': id_pelanggan,
      };
}
