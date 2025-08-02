import 'dart:io';
import 'package:http/http.dart' as http;

class PenjualanService {
  static Future<http.Response> uploadProduk({
    required String token,
    required String namaProduk,
    required String harga,
    required String stok,
    required File gambar,
    File? ktp,
  }) async {
    var url = Uri.parse('http://192.168.1.5:8000/api/penjualan/store'); // Ganti sesuai IP/backend

    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['nama_produk'] = namaProduk;
    request.fields['harga'] = harga;
    request.fields['stok_gabah'] = stok;

    request.files.add(await http.MultipartFile.fromPath('gambar', gambar.path));

    if (ktp != null) {
      request.files.add(await http.MultipartFile.fromPath('ktp', ktp.path));
    }

    final response = await request.send();
    return await http.Response.fromStream(response);
  }
}
