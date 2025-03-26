import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/base_screen/base_screen.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

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
                child: Obx(
                  () {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (controller.mesas.isNotEmpty) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 40,
                          mainAxisSpacing: 40,
                        ),
                        itemCount: controller.mesas.length,
                        itemBuilder: (context, index) {
                          final table = controller.mesas[index];
                          return ElevatedButton(
                            onPressed: () {
                              context.go(
                                  '/mesa/${table.id}'); // Navigate using table.id
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: table.active
                                  ? Colors.green
                                  : Colors
                                      .red, // Button color based on active status
                              foregroundColor: Colors.white, // Text/icon color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ), // Squared shape
                              padding: const EdgeInsets.all(10), // Adjust size
                              elevation: 4, // Slight elevation for depth
                              // Customize hover and press animations
                              animationDuration:
                                  const Duration(milliseconds: 200),
                            ),
                            child: Text(
                              table.number.toString(), // Display table number
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "No hay ninguna mesa disponible",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
