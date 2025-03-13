import 'package:flutter/material.dart';
import '../../widgets/base_screen.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  // Lista de mesas disponibles
  final List<String> mesas = [
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Restaurante',
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mesas',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: mesas.isNotEmpty
                    ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 4 columnas
                          crossAxisSpacing: 40,
                          mainAxisSpacing: 40,
                        ),
                        itemCount: mesas.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.orange, // Color de las mesas
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                mesas[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          "No hay ninguna mesa disponible",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
