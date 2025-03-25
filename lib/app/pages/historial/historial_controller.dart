import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:billbreaker_admin/app/app.dart' as app;

class HistorialPageController extends GetxController {
  RxList historial = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistorial(); // Fetch data on initialization
  }

  void fetchHistorial() async {
      // Define the API endpoint
      const String apiUrl = 'https://api.billbreaker.com.ar/database/history';

      // Set up headers with apiKey and restaurantId
      final Map<String, String> headers = {
        'X-API-Key': app.apiKey,
        'X-Restaurant-ID': app.restaurantId,
        'Content-Type': 'application/json',
      };

      // Make the GET request
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );
      
      final rawHistorial = jsonDecode(response.body)['data'];

      // Update the historial list with the fetched data
      historial.value = rawHistorial;

      }

}