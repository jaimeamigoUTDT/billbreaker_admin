import 'dart:convert'; 
import 'package:http/http.dart' as http;
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
        
          app.supabaseToken = queryContent['apiKey'];
          app.restaurantId = queryContent['restaurante_username'];
          app.isAuthenticated = true;
        } else {
          app.isAuthenticated = false;
        }
      }
    } catch (e) {
      app.isAuthenticated = false;
    }
  }

  Future<bool> register(String email, String password) async {
    final Uri authenticationUrl =
        Uri.parse('https://api.billbreaker.com.ar/auth/register');

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

  void logout() => app.isAuthenticated = false;
}
