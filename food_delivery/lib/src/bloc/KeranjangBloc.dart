import 'package:food_delivery/src/model/KeranjangModel.dart';
import 'package:food_delivery/src/repository/KeranjangRepo.dart';
import 'package:rxdart/rxdart.dart';

class KeranjangBloc {
  final _cartRepo = KeranjangRepo();

  final _getAllKeranjang = PublishSubject<List<KeranjangModel>>();

  Observable<List<KeranjangModel>> get countKeranjang =>
      _getAllKeranjang.stream;

  getKeranjang(String id_pelanggan) async {
    List<KeranjangModel> produk = await _cartRepo.getKeranjang(id_pelanggan);
    _getAllKeranjang.sink.add(produk);
  }

  tambahKeranjang(Map<String, String> data) {
    return _cartRepo.tambahKeranjang(data);
  }

  ubahQtyKeranjang(Map<String, String> data) {
    return _cartRepo.ubahQtyKeranjang(data);
  }

  hapusItemKeranjang(String id) {
    return _cartRepo.hapusItemKeranjang(id);
  }

  getTotalItem(String id_pelanggan) {
    return _cartRepo.getTotalItem(id_pelanggan);
  }

  dispose() async {
    await _getAllKeranjang.drain();
    _getAllKeranjang.close();
  }
}

final keranjangBloc = KeranjangBloc();
