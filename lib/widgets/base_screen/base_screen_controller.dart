import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class BaseScreenController extends GetxController {
  // Reactive variable to store the current route
  final RxString currentRoute = ''.obs;

  // Method to update the current route based on the context
  void updateCurrentRoute(BuildContext context) {
    currentRoute.value = GoRouterState.of(context).uri.toString();
  }

  // Method to navigate to a new route
  void navigateTo(BuildContext context, String route) {
    if (currentRoute.value != route) {
      context.go(route);
      currentRoute.value = route; // Update the reactive variable
    }
  }
}