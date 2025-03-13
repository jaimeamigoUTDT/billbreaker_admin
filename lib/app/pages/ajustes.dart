import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/base_screen.dart';

class AjustesPage extends StatelessWidget {
  const AjustesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Ajustes',
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ajustes',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSettingsItem("Cuenta"),
                    _buildSettingsItem("Notificaciones"),
                    _buildSettingsItem("Privacidad"),
                    _buildSettingsItem("Seguridad"),
                    _buildSettingsItem("General"),
                    _buildSettingsItem("Integraciones", context), // Agregamos el contexto para la navegación
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, [BuildContext? context]) {
    return GestureDetector(
      onTap: () {
        if (title == "Integraciones" && context != null) {
          context.go('/integraciones'); // Navega a la pantalla de Integraciones
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(title),
      ),
    );
  }
}
