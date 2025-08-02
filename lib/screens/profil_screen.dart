import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _imageFile;
  final picker = ImagePicker();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _logout() {
    // TODO: Implement backend logout
    Navigator.pop(context); // Misal kembali ke login/landing
  }

  void _editProfile() {
    // TODO: Kirim data ke backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit profil berhasil disimpan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.green[300],
                child: const Center(
                  child: Text(
                    "PETANI INDRAMAYU",
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(controller: namaController, label: 'Nama Lengkap'),
              _buildTextField(controller: alamatController, label: 'Alamat'),
              _buildTextField(controller: noHpController, label: 'No Hp'),
              _buildTextField(controller: emailController, label: 'Email'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _editProfile,
                child: const Text("Edit Profil"),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _logout,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 5),
                    Text("Logout", style: TextStyle(color: Colors.red)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}