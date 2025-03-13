import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_appbar.dart';

class BaseScreen extends StatefulWidget {
  final String title;
  final Widget body;

  const BaseScreen({super.key, required this.title, required this.body});

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).uri.toString(); // Nueva forma de obtener la ruta actual

    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Row(
        children: [
          // Barra de navegación lateral
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              border: const Border(
                right: BorderSide(color: Colors.grey, width: 1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildNavItem(context, Icons.home, 'Inicio', '/home', currentRoute),
                const SizedBox(height: 25),
                _buildNavItem(context, Icons.history, 'Historial', '/historial', currentRoute),
                const SizedBox(height: 25),
                _buildNavItem(context, Icons.bar_chart, 'Estadísticas', '/estadisticas', currentRoute),
                const SizedBox(height: 25),
                _buildNavItem(context, Icons.settings, 'Ajustes', '/ajustes', currentRoute),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Contenido de la pantalla
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.body,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route, String currentRoute) {
    bool isActive = currentRoute == route; // Verifica si el ícono corresponde a la ruta actual

    return IconButton(
      icon: Icon(
        icon,
        size: 28,
        color: isActive ? Colors.orange : Colors.black54, // Cambia de color si está activo
      ),
      onPressed: () {
        if (!isActive) {
          context.go(route); // Solo navega si no está en la misma ruta
          setState(() {}); // Forza la actualización del estado para reflejar el cambio de color
        }
      },
    );
  }
}
