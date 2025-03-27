import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_html/html.dart' as html;
import 'package:http/http.dart' as http;

class MesaPageController extends GetxController {
  late String qrUrl;
  final RxBool isDownloading = false.obs; // For download button
  final RxBool isQrLoading = true.obs; // For main QR image

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, String>?;
    if (args != null) {
      setQrUrl(args['restaurantId']!, args['tableNumber']!);
    }
  }

  Future<void> setQrUrl(String restaurantId, String tableNumber) async {
    isQrLoading.value = true; // Start loading
    qrUrl = 'https://api.billbreaker.com.ar/functions/qr/$restaurantId/$tableNumber';
    // Simulate a 2-second delay to ensure loading is visible
    await Future.delayed(const Duration(seconds: 2));
    isQrLoading.value = false; // Stop loading after delay
  }

  Future<void> downloadQR(String tableNumber) async {
    if (kIsWeb) {
      try {
        isDownloading.value = true;
        final response = await http.get(Uri.parse(qrUrl));
        if (response.statusCode == 200) {
          final blob = html.Blob([response.bodyBytes], 'image/png');
          final url = html.Url.createObjectUrlFromBlob(blob);
          final anchor = html.AnchorElement(href: url)
            ..setAttribute("download", "qr_mesa_$tableNumber.png")
            ..click();
          html.Url.revokeObjectUrl(url);
        } else {
          Get.snackbar(
            'Error',
            'Failed to fetch QR code: ${response.statusCode}',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Error downloading QR: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        isDownloading.value = false;
      }
    } else {
      Get.snackbar(
        'Error',
        'Download only available on web',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}