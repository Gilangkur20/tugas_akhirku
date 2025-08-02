import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

Future<void> uploadProdukKeLaravel({
  required String nama,
  required String alamat,
  required String noHp,
  required String hargaProduk,
  required String stokGabah,
  required File fotoProduk,
  File? fotoKtp,
}) async {
  final uri = Uri.parse('http://192.168.1.5:8000/api/penjualan');
  final request = http.MultipartRequest('POST', uri);

  request.fields['nama'] = nama;
  request.fields['alamat'] = alamat;
  request.fields['no_hp'] = noHp;
  request.fields['harga_produk'] = hargaProduk;
  request.fields['stok_gabah'] = stokGabah;

  request.files.add(await http.MultipartFile.fromPath(
    'foto_produk',
    fotoProduk.path,
    contentType: MediaType('image', 'jpeg'),
    filename: basename(fotoProduk.path),
  ));

  if (fotoKtp != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'foto_ktp',
      fotoKtp.path,
      contentType: MediaType('image', 'jpeg'),
      filename: basename(fotoKtp.path),
    ));
  }

  final response = await request.send();

  if (response.statusCode == 200) {
    print("✅ Produk berhasil diupload");
  } else {
    final resBody = await response.stream.bytesToString();
    print("❌ Upload gagal: $resBody");
  }
}