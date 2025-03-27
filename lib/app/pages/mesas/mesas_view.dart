import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/base_screen/base_screen.dart';
import 'mesas_controller.dart';

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
    Get.put(MesaPageController(), permanent: false);
    MesaPageController mesaController = Get.find<MesaPageController>();

    // Set QR URL on init by passing arguments (async call)
    mesaController.setQrUrl(restaurantId, tableNumber);

    return BaseScreen(
      title: 'Mesa $tableNumber',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Obx(
              () => mesaController.isQrLoading.value
                  ? const SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Image.network(
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
          ),
          const SizedBox(height: 20),
          Obx(
            () => ElevatedButton.icon(
              onPressed: mesaController.isDownloading.value
                  ? null
                  : () {
                      mesaController.downloadQR(tableNumber);
                    },
              icon: mesaController.isDownloading.value
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.download),
              label: Text(
                mesaController.isDownloading.value ? "Descargando..." : "Descargar QR",
              ),
            ),
          ),
        ],
      ),
    );
  }
}