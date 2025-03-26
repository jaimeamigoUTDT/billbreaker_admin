import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_screen_controller.dart';
import 'package:billbreaker_admin/widgets/custom_appbar.dart';

class BaseScreen extends GetView<BaseScreenController> {
  final String title;
  final Widget body;

  const BaseScreen({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller if not already done (ideally done elsewhere)
    Get.put(BaseScreenController());

    // Delay the route update to avoid build-phase conflicts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.updateCurrentRoute(context);
    });

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: Row(
        children: [
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
                _buildNavItem(context, Icons.home, 'Inicio', '/home'),
                const SizedBox(height: 25),
                _buildNavItem(context, Icons.history, 'Historial', '/historial'),
                const SizedBox(height: 25),
                _buildNavItem(context, Icons.bar_chart, 'Estadísticas', '/estadisticas'),
                const SizedBox(height: 25),
                _buildNavItem(context, Icons.settings, 'Integraciones', '/integraciones'),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: body,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Obx(
      () {
        bool isActive = controller.currentRoute.value == route;

        return IconButton(
          icon: Icon(
            icon,
            size: 28,
            color: isActive ? Colors.orange : Colors.black54,
          ),
          onPressed: () {
            controller.navigateTo(context, route);
          },
        );
      },
    );
  }
}