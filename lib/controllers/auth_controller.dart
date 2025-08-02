import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir/consts/app_const.dart';

class AuthController {
  final String _registerUrl = '${AppConst.baseUrl}/api/register';
  final String _loginUrl = '${AppConst.baseUrl}/api/login';
  final box = GetStorage();

  /// REGISTER
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String alamat,
    required String noHp,
  }) async {
    final url = Uri.parse(_registerUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'alamat': alamat,
          'no_hp': noHp,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Registrasi berhasil',
          'user': data['user'],
        };
      } else {
        return {
          'success': false,
          'errors': data['errors'] ?? {'error': data['message'] ?? 'Terjadi kesalahan'},
        };
      }
    } catch (e) {
      return {
        'success': false,
        'errors': {'exception': e.toString()},
      };
    }
  }

  /// LOGIN
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print("Login Response Status: ${response.statusCode}");
      print("Login Response Body: ${response.body}");

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 && body['success'] == true) {
        final token = body['token'];
        final user = body['user'];

        box.write('token', token);
        box.write('user', user);

        return {'success': true, 'token': token, 'user': user};
      } else {
        return {
          'success': false,
          'message': body['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}
