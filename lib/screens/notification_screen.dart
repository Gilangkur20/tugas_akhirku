import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Contoh data notifikasi
  List<String> notifikasi = [
    // Akan diisi saat pesanan dikonfirmasi atau masuk
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifikasi"),
        backgroundColor: Colors.green[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: notifikasi.isEmpty
          ? const Center(
              child: Text(
                'Belum Ada Notifikasi',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            )
          : ListView.builder(
              itemCount: notifikasi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text(notifikasi[index]),
                );
              },
            ),
    );
  }
}