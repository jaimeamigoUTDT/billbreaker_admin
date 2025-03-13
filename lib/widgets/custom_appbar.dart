import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          SvgPicture.asset(
            'assets/logo.svg',  // Ruta de tu logo
            height: 30,         // Ajusta el tamaño según necesidad
          ),
          const SizedBox(width: 10), // Espacio entre el logo y el texto
          Padding(
            padding: const EdgeInsets.only(left: 10), // Padding de 5px a la izquierda del título
            child: const Text("Billbreaker"),
          ),
        ],
      ),
      backgroundColor: Colors.orange,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
