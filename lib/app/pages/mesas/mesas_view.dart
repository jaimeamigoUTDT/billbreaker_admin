import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/base_screen/base_screen.dart';
import 'mesas_controller.dart'; // Single import is enough

class MesaPage extends GetView<MesaPageController> {
  final String restaurantId;
  final String tableNumber;

  const MesaPage({
    super.key,
    required this.restaurantId,
    required this.tableNumber,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize or find the controller
    // If not already initialized elsewhere, use Get.put here
    Get.put(MesaPageController(), permanent: false); // Initialize if not found
    MesaPageController mesaController = Get.find<MesaPageController>();

    // Set QR URL on init by passing arguments
    mesaController.setQrUrl(restaurantId, tableNumber);

    return BaseScreen(
      title: 'Mesa $tableNumber',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
              mesaController.qrUrl,
              width: 200,
              height: 200,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 200,
                  height: 200,
                  child: Center(child: Text("No se pudo cargar el QR")),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              mesaController.downloadQR(tableNumber);
            },
            icon: const Icon(Icons.download),
            label: const Text("Descargar QR"),
          ),
        ],
      ),
    );
  }
}