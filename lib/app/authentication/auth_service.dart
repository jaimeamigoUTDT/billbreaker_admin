import 'dart:convert'; // Required for jsonDecode
import 'package:http/http.dart' as http;

import '../app.dart' as app;

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  bool isAuthenticated = false;

  Future<void> login(String email, String password) async {

    final Uri authenticationUrl = Uri.parse('https://api.billbreaker.com.ar/auth/login');

    // Create the request body with email and password
    final Map<String, String> body = {
      'email': email,
      'password': password,
    };

    try {
      // Send a POST request with JSON body
      final http.Response response = await http.post(
        authenticationUrl,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {

        final Map<String, dynamic> queryContent = jsonDecode(response.body);

        isAuthenticated = true;
        app.restaurante_id = queryContent['restaurante_id'];

      } else {

        print('Login failed with status code: ${response.statusCode}');
        isAuthenticated = false;
      }
    } catch (e) {

      print('Error during login: $e');
      isAuthenticated = false;
    }
  }

  void logout() => isAuthenticated = false;
}