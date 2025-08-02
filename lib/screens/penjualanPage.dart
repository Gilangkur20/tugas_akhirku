// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/screens/berandapage.dart';

class PenjualanPage extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();

  PenjualanPage({super.key});
  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  File? foto_produk;
  Future savePenjualan() async {
    final response = await http.post(Uri.parse('http://10.0.167.192:8000/api/penjualan'), body: {
      'nama': namaController.text,
      'harga_produk': hargaController.text,
      'stok_gabah': stokController.text,
      
      // Tambahkan field lain yang diperlukan
    });

    print(response.body);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan'),
        backgroundColor: Colors.green[700],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama barang tidak boleh kosong';
                } 
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: hargaController,
              decoration: const InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harga barang tidak boleh kosong';
                } 
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: stokController,
              decoration: const InputDecoration(
                labelText: 'stok gabah',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Stok barang tidak boleh kosong';
                } 
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            const Icon(Icons.image, size: 40, color: Colors.grey),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  // Lakukan sesuatu dengan gambar yang dipilih
                }
              },
              child: const Text('Pilih Gambar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  // Lakukan sesuatu dengan gambar yang dipilih
                }
              },
              child: const Text('Pilih Gambar'),
            ),
            ElevatedButton(
              onPressed: () {
                // ignore: avoid_print
                if (_formKey.currentState!.validate()) {
                  savePenjualan().then((value) {
                    // ignore: avoid_print
                    print('Penjualan berhasil disimpan');
                  }).catchError((error) {
                    // ignore: avoid_print
                    print('Terjadi kesalahan saat menyimpan penjualan: $error');
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BerandaPage()));
                  // Tambahkan logika untuk menyimpan gambar jika diperlukan
                } else {
                  print('Form tidak valid');
                }
                // Logika untuk menyimpan data penjualan
              },
              child: const Text('Simpan Penjualan'),
            ),
          ],
        ),
      ),
    );
  }
}
