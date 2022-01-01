class BaseURL {
  static String domain = "http://10.0.2.2/";

  static String baseURL = domain + "food-delivery/api/";
  static String baseURLImg = domain + "food-delivery/public/uploads/img/";

  // Produk
  static String urlGetProduk = baseURL + "produk";

  // Auth
  static String urlGetValidateEmail = baseURL + "auth/getValidateEmail";
  static String urlLogin = baseURL + "auth/login";
  static String urlRegister = baseURL + "auth/register";
  static String urlSimpanPassword = baseURL + "auth/simpanPassword";

  // Keranjang
  static String urlGetKeranjang = baseURL + "keranjang";
  static String urlTambahKeranjang = baseURL + "keranjang/tambahKeranjang";
  static String urlUbahQtyKeranjang = baseURL + "keranjang/ubahQtyKeranjang";
  static String urlGetTotalItem = baseURL + "keranjang/getTotalItem";
  static String urlHapusItemKeranjang =
      baseURL + "keranjang/hapusItemKeranjang";

  // Transaksi Pemesanan
  static String urlGetTotalBayar = baseURL + "pemesanan/getTotalBayar";
  static String urlKirimPesanan = baseURL + "pemesanan";
  static String urlGetTransaksi = baseURL + "pemesanan/getTransaksi";
  static String urlGetItemTransaksi = baseURL + "pemesanan/getItemTransaksi";
}
