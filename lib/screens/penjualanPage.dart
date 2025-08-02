import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class PenjualanPage extends StatefulWidget {
  const PenjualanPage({Key? key}) : super(key: key);

  @override
  State<PenjualanPage> createState() => _PenjualanPageState();
}

class _PenjualanPageState extends State<PenjualanPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaProdukController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noHpController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final box = GetStorage();

  File? _gambarProduk;
  File? _gambarKTP;

  Future<void> _pickImage(bool isKTP) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isKTP) {
          _gambarKTP = File(pickedFile.path);
        } else {
          _gambarProduk = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _uploadProduk() async {
    if (_formKey.currentState!.validate() && _gambarProduk != null && _gambarKTP != null) {
      final token = box.read('token');
      print('Token: $token'); // Debug token
      if (token == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Silakan login terlebih dahulu!')),
          );
        }
        return;
      }

      final uri = Uri.parse('http://192.168.1.5:8000/api/penjualan');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['nama'] = _namaProdukController.text
        ..fields['alamat'] = _alamatController.text
        ..fields['no_hp'] = _noHpController.text
        ..fields['harga_produk'] = _hargaController.text
        ..fields['stok_gabah'] = _stokController.text
        ..files.add(await http.MultipartFile.fromPath('foto_produk', _gambarProduk!.path))
        ..files.add(await http.MultipartFile.fromPath('foto_ktp', _gambarKTP!.path));

      print('Request Headers: ${request.headers}'); // Debug headers
      print('Request Fields: ${request.fields}'); // Debug fields

      try {
        final response = await request.send();
        final resBody = await response.stream.bytesToString();
        print('Status Code: ${response.statusCode}');
        print('Response Body: $resBody');

        if (response.statusCode == 200) {
          final resJson = json.decode(resBody);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Upload berhasil: ${resJson['message']}')),
            );
          }
          Navigator.pop(context);
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Upload gagal: $resBody')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terjadi kesalahan: $e')),
          );
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lengkapi semua data dan gambar!')),
        );
      }
    }
  }

  Widget buildRoundedInput(String label, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) => value == null || value.isEmpty ? '$label wajib diisi' : null,
        decoration: InputDecoration(
          labelText: label,
          hintText: 'Tulis disini......',
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildUploadBox(String label, File? imageFile, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: imageFile == null
                  ? const Icon(Icons.image, size: 40, color: Colors.grey)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(imageFile, width: double.infinity, fit: BoxFit.cover),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    _namaProdukController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    _hargaController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'PETANI INDRAMAYU',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildRoundedInput('Nama Produk', _namaProdukController),
              buildRoundedInput('Alamat', _alamatController),
              buildRoundedInput('No Hp', _noHpController, keyboardType: TextInputType.phone),
              buildRoundedInput('Harga Produk', _hargaController, keyboardType: TextInputType.number),
              buildRoundedInput('Jumlah stok Gabah', _stokController, keyboardType: TextInputType.number),
              buildUploadBox('Upload Gambar', _gambarProduk, () => _pickImage(false)),
              buildUploadBox('Upload KTP', _gambarKTP, () => _pickImage(true)),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _uploadProduk,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text('Upload', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}