import 'package:get/get.dart';
import 'package:tugas_akhir/bindings/register_binding.dart';
import 'package:tugas_akhir/bindings/login_binding.dart'; // ✅ Import binding login
import 'package:tugas_akhir/regis dan login/login_screen.dart';
import 'package:tugas_akhir/regis dan login/register_screen.dart';
import 'package:tugas_akhir/screens/main_bottom_bar.dart';

class AppRoutes {
  static const String register = '/register';
  static const String login = '/login';
  static const String home = '/home';

  static final routes = [
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(), // ✅ Register binding
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: LoginBinding(), // ✅ Login binding ditambahkan
    ),
    GetPage(name: home, page: () => MainBottomNav()),
  ];
}
