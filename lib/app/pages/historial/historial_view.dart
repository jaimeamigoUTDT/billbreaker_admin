import 'package:billbreaker_admin/app/pages/historial/historial_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/base_screen.dart';

class HistorialPage extends GetView<HistorialPageController> {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already present
    Get.put(HistorialPageController(), permanent: false);
    HistorialPageController histController = Get.find<HistorialPageController>();

    return BaseScreen(
      title: 'Actividad',
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actividad',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // FloatingActionButton to trigger fetchHistorial
            FloatingActionButton(
              onPressed: () {
                histController.fetchHistorial();
              },
              child: const Icon(Icons.refresh),
            ),
            const SizedBox(height: 10),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar en el historial...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Use Obx to rebuild when historial changes
            Expanded(
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: histController.historial.isNotEmpty
                      ? SingleChildScrollView(
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Fecha')),
                              DataColumn(label: Text('Estado')),
                              DataColumn(label: Text('Numero de mesa')),
                            ],
                            rows: histController.historial.map((item) {
                              return DataRow(cells: [
                                DataCell(Text(item["accion"] ?? 'N/A')),
                                DataCell(Text(item["estado"] ?? 'N/A')),
                                DataCell(Text(item["numero_mesa"] ?? 'N/A')),
                                
                              ]);
                            }).toList(),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "No hay registros en el historial",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}