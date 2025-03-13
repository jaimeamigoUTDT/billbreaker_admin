import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html show AnchorElement;

class MesaPageController extends GetxController {
  late String qrUrl;

  @override
  void onInit() {
    super.onInit();
    // We’ll pass restaurantId and tableNumber via Get.arguments or constructor
    final args = Get.arguments as Map<String, String>?;
    if (args != null) {
      setQrUrl(args['restaurantId']!, args['tableNumber']!);
    }
  }

  void setQrUrl(String restaurantId, String tableNumber) {
    qrUrl = 'https://api.billbreaker.com.ar/functions/qr/$restaurantId/$tableNumber';
  }

  void downloadQR(String tableNumber) {
    if (kIsWeb) {
      final anchor = html.AnchorElement(href: qrUrl)
        ..setAttribute("download", "qr_mesa_$tableNumber.png")
        ..click();
    } else {
      Get.snackbar(
        'Error',
        'Download only available on web',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}