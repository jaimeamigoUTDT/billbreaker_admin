import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';

class IntegracionesPage extends StatefulWidget {
  const IntegracionesPage({Key? key}) : super(key: key);

  @override
  _IntegracionesPageState createState() => _IntegracionesPageState();
}

class _IntegracionesPageState extends State<IntegracionesPage> {
  String? seleccionActual; // Almacena la integración seleccionada

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Integraciones',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Integraciones',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Fila con las integraciones (Mercado Pago y Fudo)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildIntegrationCard('assets/mercado_pago.jpg', 'Mercado Pago'),
                const SizedBox(width: 20),
                _buildIntegrationCard('assets/fudo.webp', 'Fudo'),
              ],
            ),

            const SizedBox(height: 30), // Espaciado entre la fila y el formulario

            // Contenedor con campos de texto según la selección
            if (seleccionActual != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey[400]!),
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Configuración de $seleccionActual",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),

                    // Campos según la integración seleccionada
                    if (seleccionActual == "Mercado Pago")
                      _buildTextFieldWithButton("Access Token"),
                    if (seleccionActual == "Fudo") ...[
                      _buildTextFieldWithButton("API Key"),
                      const SizedBox(height: 15),
                      _buildTextFieldWithButton("API Secret"),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithButton(String labelText) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10), // Espaciado entre el campo y el botón
        ElevatedButton(
          onPressed: () {
            print("Actualizando $labelText...");
          },
          child: const Text("Actualizar"),
        ),
      ],
    );
  }
Widget _buildIntegrationCard(String? imagePath, String? nombre) {
  return GestureDetector(
    onTap: () {
      if (nombre != null) {
        setState(() {
          seleccionActual = nombre;
        });
      }
    },
    child: Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: nombre == "Fudo" ? const Color(0xFFEF3A21) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: seleccionActual == nombre ? Colors.orange : Colors.grey[400]!,
          width: seleccionActual == nombre ? 2 : 1,
        ),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: imagePath != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // Eliminamos la manipulación del color
              ),
            )
          : null,
    ),
  );
}
} 