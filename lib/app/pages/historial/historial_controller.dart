import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:billbreaker_admin/app/app.dart' as app;

class HistorialPageController extends GetxController {
  RxList historial = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistorial(); // Fetch data on initialization
  }

  Future<void> fetchHistorial() async {
    try {
      // Define the API endpoint
      const String apiUrl = 'https://api.billbreaker.com.ar/database/history';

      // Set up headers with apiKey and restaurantId
      final Map<String, String> headers = {
        'X-API-Key': app.supabaseToken,
        'X-Restaurant-ID': app.restaurantId,
        'Content-Type': 'application/json',
      };

      // Make the GET request
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        final List<dynamic> rawData = jsonDecode(response.body);

        // Map the data to include only "fecha", "estado", and "numero de mesa"
        final List<Map<String, dynamic>> filteredData = rawData.map((item) {
          return {
            'fecha': item['created_at']?.toString() ?? 'N/A',
            'estado': item['estado']?.toString() ?? 'N/A',
            'numero_mesa': item['numero_mesa']?.toString() ?? 'N/A',
          };
        }).toList();

        // Update the observable list with the filtered data
        historial.value = filteredData;
      } else {
        Get.snackbar('Error', 'Failed to fetch historial: ${response.statusCode}');
        historial.value = []; // Clear list on error
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error: $e');
      historial.value = []; // Clear list on error
    }
  }
}