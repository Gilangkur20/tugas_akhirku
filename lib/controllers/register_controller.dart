import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir/controllers/auth_controller.dart';
import 'package:tugas_akhir/routes/app_route.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final alamatController = TextEditingController();
  final noHpController = TextEditingController();

  var isLoading = false.obs;

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      final result = await AuthController().register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        alamat: alamatController.text,
        noHp: noHpController.text,
      );

      isLoading.value = false;

      if (result['success']) {
        Get.snackbar("Sukses", "Registrasi berhasil!",
            snackPosition: SnackPosition.BOTTOM);
        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offNamed(AppRoutes.login);
        });
      } else {
        final errors = result['errors'];
        Get.snackbar("Gagal", errors.toString(),
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
        debugPrint('🔴 Error saat registrasi: $errors');
      }
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    alamatController.dispose();
    noHpController.dispose();
    super.onClose();
  }
}