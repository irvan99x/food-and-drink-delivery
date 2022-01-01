import 'package:food_delivery/src/model/KeranjangModel.dart';
import 'package:food_delivery/src/provider/KeranjangProvider.dart';

class KeranjangRepo {
  final _cartProvider = KeranjangProvider();

  Future<List<KeranjangModel>> getKeranjang(String id_pelanggan) {
    return _cartProvider.getKeranjang(id_pelanggan);
  }

  Future tambahKeranjang(Map<String, String> data) {
    return _cartProvider.tambahKeranjang(data);
  }

  Future ubahQtyKeranjang(Map<String, String> data) {
    return _cartProvider.ubahQtyKeranjang(data);
  }

  Future hapusItemKeranjang(String id) {
    return _cartProvider.hapusItemKeranjang(id);
  }

  Future getTotalItem(String id_pelanggan) {
    return _cartProvider.getTotalItem(id_pelanggan);
  }
}
