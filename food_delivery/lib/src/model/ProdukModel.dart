import 'dart:convert';

List<ProdukModel> produkFromJson(String str) {
  final jsonData = jsonDecode(str);
  return List<ProdukModel>.from(jsonData.map((x) => ProdukModel.fromJson(x)));
}

class ProdukModel {
  String id;
  String nama_produk;
  String harga;
  String deskripsi;
  String gambar;
  String status;
  String kategori;

  ProdukModel({
    this.id,
    this.nama_produk,
    this.harga,
    this.deskripsi,
    this.gambar,
    this.status,
    this.kategori,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
        id: json['id'],
        nama_produk: json['nama_produk'],
        harga: json['harga'],
        deskripsi: json['deskripsi'],
        gambar: json['gambar'],
        status: json['status'],
        kategori: json['kategori'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_produk': nama_produk,
        'harga': harga,
        'deskripsi': deskripsi,
        'gambar': gambar,
        'status': status,
        'kategori': kategori
      };
}
