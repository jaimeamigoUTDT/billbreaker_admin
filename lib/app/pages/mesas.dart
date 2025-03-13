import 'package:flutter/material.dart';
import 'dart:html' as html; // Para manejar descargas en web
import '../../widgets/base_screen.dart';

class MesaPage extends StatefulWidget {
  final String restaurantId;
  final String tableNumber;

  const MesaPage({
    super.key,
    required this.restaurantId,
    required this.tableNumber,
  });

  @override
  _MesaPageState createState() => _MesaPageState();
}

class _MesaPageState extends State<MesaPage> {
  late String qrUrl;

  @override
  void initState() {
    super.initState();
    qrUrl = "https://api.billbreaker.com.ar/functions/qr/${widget.restaurantId}/${widget.tableNumber}";
  }

  /// Descarga el QR usando un enlace en Flutter Web
  void downloadQR() {
    final anchor = html.AnchorElement(href: qrUrl)
      ..setAttribute("download", "qr_mesa_${widget.tableNumber}.png") // Nombre del archivo
      ..click(); // Simula el clic para descargar
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Mesa ${widget.tableNumber}', // ✅ Se actualiza el título con el número de mesa
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.network(
              qrUrl,
              width: 200,
              height: 200,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) {
                return const Text("No se pudo cargar el QR");
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: downloadQR, // Usa la función de descarga para WebApp
            icon: const Icon(Icons.download),
            label: const Text("Descargar QR"),
          ),
        ],
      ),
    );
  }
}
