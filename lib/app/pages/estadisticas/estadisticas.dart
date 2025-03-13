import 'package:flutter/material.dart';
import '../../../widgets/base_screen.dart';

class EstadisticasPage extends StatelessWidget {
  const EstadisticasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Estadísticas',
      body: Center(
        child: Text(
          'Coming Soon...',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
    );
  }
}
