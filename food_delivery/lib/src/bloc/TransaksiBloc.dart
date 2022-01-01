import 'package:food_delivery/src/model/LogPemesananModel.dart';
import 'package:food_delivery/src/model/TransaksiModel.dart';
import 'package:food_delivery/src/repository/TransaksiRepo.dart';
import 'package:rxdart/rxdart.dart';

class TransaksiBloc {
  final _repo = TransaksiRepo();

  final _getTransaksi = PublishSubject<List<TransaksiModel>>();
  Stream<List<TransaksiModel>> get countTransaksi => _getTransaksi.stream;

  final _getItemTransaksi = PublishSubject<List<LogPemesananModel>>();
  Stream<List<LogPemesananModel>> get countItemTransaksi =>
      _getItemTransaksi.stream;

  getTotalBayar(String id_pelanggan) {
    return _repo.getTotalBayar(id_pelanggan);
  }

  kirimPesanan(Map<String, String> data) {
    return _repo.kirimPesanan(data);
  }

  getTransaksi(String id_pelanggan) async {
    List<TransaksiModel> trf = await _repo.getTransaksi(id_pelanggan);
    _getTransaksi.sink.add(trf);
  }

  getItemTransaksi(
    String kd_pemesanan,
    String id_pelanggan,
  ) async {
    List<LogPemesananModel> lg = await _repo.getItemTransaksi(
      kd_pemesanan,
      id_pelanggan,
    );
    _getItemTransaksi.sink.add(lg);
  }

  dispose() async {
    await _getTransaksi.drain();
    _getTransaksi.close();
  }

  diposeLog() async {
    await _getItemTransaksi.drain();
    _getItemTransaksi.close();
  }
}

final transaksiBloc = TransaksiBloc();
