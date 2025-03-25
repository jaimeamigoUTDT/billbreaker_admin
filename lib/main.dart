import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'app/app.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/pages/mesas/mesas_controller.dart';
import 'app/app.dart' as app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isAuthenticated') ?? false;
  final apiKey = prefs.getString('apiKey') ?? '';
  final restaurantId = prefs.getString('restaurantId') ?? '';

  app.isAuthenticated = isLoggedIn;
  app.apiKey = apiKey;
  app.restaurantId = restaurantId;

  // Initialize AuthService
  Get.put(MesaPageController());
  usePathUrlStrategy();
  runApp(BillbreakerAdminDashboard());
}