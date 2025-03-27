import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:billbreaker_admin/app/models/table_model.dart'; // Import your TableModel
import 'package:billbreaker_admin/app/app.dart' as app;

class HomeController extends GetxController {
  // Reactive list of TableModel objects
  final RxList<TableModel> mesas = <TableModel>[].obs;

  // Reactive loading state
  final RxBool isLoading = true.obs;
  

  @override
  void onInit() {
    super.onInit();
    getMesas();
  }

  // Fetch mesas from the API and parse into TableModel
  Future<void> getMesas() async {
    try {
      isLoading.value = true;

      const String apiUrl = 'https://api.billbreaker.com.ar/foodserver/mesas';

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

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        mesas.value = data.map((json) => TableModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load mesas');
      }
    } catch (e) {
      print('Error fetching mesas: $e');
      mesas.value = [];
    } finally {
      isLoading.value = false;
    }
  }



}