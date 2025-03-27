import 'package:billbreaker_admin/app/pages/historial/historial_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import '../../../widgets/base_screen/base_screen.dart';

class HistorialPage extends GetView<HistorialPageController> {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller if not already present
    Get.put(HistorialPageController(), permanent: false);
    HistorialPageController histController = Get.find<HistorialPageController>();

    // Scroll controllers for vertical and horizontal scrolling
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

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
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: histController.historial.isNotEmpty
                      ? AdaptiveScrollbar(
                          controller: _verticalScrollController,
                          underColor: Colors.blueGrey.withOpacity(0.3),
                          sliderDefaultColor: Colors.grey.withOpacity(0.7),
                          sliderActiveColor: Colors.grey,
                          child: AdaptiveScrollbar(
                            controller: _horizontalScrollController,
                            position: ScrollbarPosition.bottom,
                            underColor: Colors.blueGrey.withOpacity(0.3),
                            sliderDefaultColor: Colors.grey.withOpacity(0.7),
                            sliderActiveColor: Colors.grey,
                            child: SingleChildScrollView(
                              controller: _verticalScrollController,
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                controller: _horizontalScrollController,
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
                                  child: DataTable(
                                    columnSpacing: 30,
                                    columns: const [
                                      DataColumn(label: Text('Fecha y hora')),
                                      DataColumn(label: Text('Monto pagado')),
                                      DataColumn(label: Text('Numero de mesa')),
                                      DataColumn(label: Text('Productos pagados')),
                                      DataColumn(label: Text('Método de pago')),
                                      DataColumn(label: Text('ID de compra')),
                                    ],
                                    rows: histController.historial.map((item) {
                                      return DataRow(cells: [
                                        DataCell(
                                          SizedBox(
                                            width: 150,
                                            child: Text(item["created_at"].toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: 100,
                                            child: Text('\$${item["monto"]}',)
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: 100,
                                            child: Text(item["numero_mesa"].toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: 400,
                                            child: Text(item["carrito"].toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: 150,
                                            child: Text(item["medio_de_pago"].toString()),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: 100,
                                            child: Text(item["id_de_pago"].toString()),
                                          ),
                                        ),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
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