import 'package:food_delivery/src/provider/AuthProvider.dart';

class AuthRepo {
  final _authProvider = AuthProvider();

  Future getValidateEmail(
    String email,
  ) {
    return _authProvider.getValidateEmail(email);
  }

  Future login(
    String email,
    String password,
  ) {
    return _authProvider.login(email, password);
  }

  Future register(
    String nama,
    String no_telp,
    String email,
    String password,
  ) {
    return _authProvider.register(
      nama,
      no_telp,
      email,
      password,
    );
  }

  Future simpanPassword(
    String id,
    String password,
  ) {
    return _authProvider.simpanPassword(
      id,
      password,
    );
  }
}
