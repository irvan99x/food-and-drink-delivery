import 'package:food_delivery/src/model/ProdukModel.dart';
import 'package:food_delivery/src/repository/ProdukRepo.dart';
import 'package:rxdart/rxdart.dart';

class ProdukBloc {
  final _produkRepo = ProdukRepo();

  final _getAllProduk = PublishSubject<List<ProdukModel>>();

  Observable<List<ProdukModel>> get countProduk => _getAllProduk.stream;

  getProduk(String kategori) async {
    List<ProdukModel> produk = await _produkRepo.getProduk(kategori);
    _getAllProduk.sink.add(produk);
  }

  dispose() async {
    await _getAllProduk.drain();
    _getAllProduk.close();
  }
}

final produkBloc = ProdukBloc();
