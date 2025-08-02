import 'package:get/get.dart';
import 'package:tugas_akhir/controllers/auth_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
