import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tugas_akhir/controllers/register_controller.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Registrasi",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(controller.nameController, "Nama Lengkap"),
                    const SizedBox(height: 12),
                    _buildTextField(controller.emailController, "Email",
                        inputType: TextInputType.emailAddress),
                    const SizedBox(height: 12),
                    _buildTextField(controller.alamatController, "Alamat"),
                    const SizedBox(height: 12),
                    _buildTextField(controller.noHpController, "No HP",
                        inputType: TextInputType.phone),
                    const SizedBox(height: 12),
                    _buildTextField(controller.passwordController, "Password",
                        isPassword: true),
                    const SizedBox(height: 12),
                    _buildTextField(controller.confirmPasswordController,
                        "Konfirmasi Password",
                        isPassword: true),
                    const SizedBox(height: 20),
                    Obx(() => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green[900],
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text("Registrasi"),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hintText, {
    TextInputType inputType = TextInputType.text,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: inputType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText tidak boleh kosong';
        }
        if (hintText == "Konfirmasi Password" &&
            value != this.controller.passwordController.text) {
          return 'Password tidak cocok';
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}