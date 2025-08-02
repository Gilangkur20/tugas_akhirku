import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir/routes/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Aplikasi Petani',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.login, // pastikan diarahkan dengan benar
      getPages: AppRoutes.routes,
    );
  }
}
