import 'package:flutter/material.dart';

class PembelianPage extends StatefulWidget {
  final Map<String, dynamic> penjual;

  const PembelianPage({Key? key, required this.penjual}) : super(key: key);

  @override
  State<PembelianPage> createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPage> {
  String _selectedSpec = '100kg';

  final Map<String, int> hargaMap = {
    '100kg': 65000,
    '500kg': 325000,
    '1 Ton': 650000,
    '2 Ton': 1300000,
  };

  Widget _buildSpecButton(String label) {
    final isSelected = _selectedSpec == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSpec = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[700] : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final penjual = widget.penjual;
    final int hargaTotal = hargaMap[_selectedSpec] ?? 65000;

    final String namaProduk = penjual['nama'] ?? 'Produk tidak dikenal';
    final String harga = penjual['harga_produk']?.toString() ?? '0';
    final String namaPenjual = penjual['nama'] ?? 'Tanpa nama';
    final String foto = penjual['foto_produk'] ?? '';
    final String imageUrl = 'http://192.168.1.5:8000/storage/$foto';

    final String pembeliNama = penjual['name'] ?? 'Gilang kur';
    final String pembeliAlamat = penjual['alamat'] ?? 'Jalan Sidomulya, No 18, RT 3 RW 7';
    final String pembeliNoHp = penjual['no_hp'] ?? '08764579875';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text("Pembelian"),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Produk
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  foto.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 100),
                        )
                      : const Icon(Icons.image, size: 100),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          namaProduk,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Rp $harga",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.person, size: 16, color: Colors.black),
                            const SizedBox(width: 6),
                            Text(namaPenjual),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Informasi Pembeli
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 4,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama : $pembeliNama"),
                  const SizedBox(height: 4),
                  Text("Alamat : $pembeliAlamat"),
                  const SizedBox(height: 4),
                  Text("No Hp : $pembeliNoHp"),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text("Spesifikasi", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSpecButton("100kg"),
                _buildSpecButton("500kg"),
                _buildSpecButton("1 Ton"),
                _buildSpecButton("2 Ton"),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "*Pembayaran di lakukan secara langsung (COD) untuk menghindari adanya penipuan!",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Total (1 item)\nRp$hargaTotal",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Action ketika klik buat pesanan
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Buat pesanan"),
            )
          ],
        ),
      ),
    );
  }
}
