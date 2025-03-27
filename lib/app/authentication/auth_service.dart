import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../app.dart' as app;

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

 Future<void> login(String email, String password) async {
    final Uri authenticationUrl =
        Uri.parse('https://api.billbreaker.com.ar/auth/login');

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

        if (queryContent['apiKey'] != null && queryContent['status'] == 'OK') {
          app.apiKey = queryContent['apiKey'];
          app.restaurantId = queryContent['restaurante_username'];
          app.isAuthenticated = true;

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isAuthenticated', true);
          await prefs.setString('apiKey', app.apiKey);
          await prefs.setString('restaurantId', app.restaurantId);

        } else {
          throw Exception('Credenciales inválidas o respuesta inesperada del servidor');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Correo o contraseña incorrectos'); // Unauthorized
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      app.isAuthenticated = false;
      throw Exception('Error al iniciar sesión: ${e.toString()}'); // Re-throw for caller
    }
  }

  Future<bool> register(String username, String email, String emailVerification, String password, String passwordVerification) async {
    final Uri authenticationUrl =
        Uri.parse('https://api.billbreaker.com.ar/auth/register');

    // Create the request body with email and password
    final Map<String, String> body = {
      'username': username,
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

        if (queryContent['status'] == 'OK') {
          
          return true;

        } else {
          return false;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  void logout() async {
    app.isAuthenticated = false;
    app.apiKey = '';
    app.restaurantId = '';

    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
