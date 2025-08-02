import 'package:flutter/material.dart';
import 'package:tugas_akhir/screens/berandapage.dart';
import 'package:tugas_akhir/screens/notification_screen.dart';
import 'package:tugas_akhir/screens/penjualanPage.dart';
import 'package:tugas_akhir/screens/profil_screen.dart';

class MainBottomNav extends StatefulWidget {
  @override
  _MainBottomNavState createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BerandaPage(),
    PenjualanPage(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Penjualan'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Notifikasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}