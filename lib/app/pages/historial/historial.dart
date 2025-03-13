import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<Map<String, String>> historial = [
    {"fecha": "2024-03-08", "usuario": "Juan", "accion": "Inició sesión"},
    {"fecha": "2024-03-08", "usuario": "María", "accion": "Creó un pedido"},
    {"fecha": "2024-03-07", "usuario": "Pedro", "accion": "Modificó un menú"},
    {"fecha": "2024-03-06", "usuario": "Ana", "accion": "Eliminó una reserva"},
    {"fecha": "2024-03-05", "usuario": "Luis", "accion": "Actualizó su perfil"},
  ];

  List<Map<String, String>> historialFiltrado = [];

  @override
  void initState() {
    super.initState();
    historialFiltrado = List.from(historial); // Iniciar con todos los datos
  }

  void _filtrarHistorial(String query) {
    setState(() {
      historialFiltrado = historial
          .where((item) =>
              item["fecha"]!.contains(query) ||
              item["usuario"]!.toLowerCase().contains(query.toLowerCase()) ||
              item["accion"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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

            // Barra de búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: "Buscar en el historial...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filtrarHistorial,
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: historialFiltrado.isNotEmpty
                    ? SingleChildScrollView(
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Fecha')),
                            DataColumn(label: Text('Usuario')),
                            DataColumn(label: Text('Acción')),
                          ],
                          rows: historialFiltrado.map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item["fecha"]!)),
                              DataCell(Text(item["usuario"]!)),
                              DataCell(Text(item["accion"]!)),
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
          ],
        ),
      ),
    );
  }
}
