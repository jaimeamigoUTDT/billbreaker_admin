import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:billbreaker_admin/app/authentication/auth_service.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  OverlayEntry? _overlayEntry;

  void _toggleLogoutMenu(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                _toggleLogoutMenu(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(),
            ),
          ),
          Positioned(
            top: kToolbarHeight + 10,
            right: 10,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () {
                    _toggleLogoutMenu(context);
                    AuthService().logout();
                    context.go('/login');
                  },
                  child: const Text(
                    "Cerrar sesión",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          SvgPicture.asset(
            'assets/logo.svg',  // Ruta del logo SVG en assets
            height: 30, // Ajustar el tamaño según necesidad
          ),
          const SizedBox(width: 10), // Espacio entre el logo y el texto
          const Text("Billbreaker"),
        ],
      ),
      backgroundColor: Colors.orange,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10), // Espacio a la derecha
          child: InkWell(
            onTap: () => _toggleLogoutMenu(context),
            child: SvgPicture.asset(
              'assets/account.svg',  // Ruta del nuevo SVG para la derecha
              height: 30, // Ajustar el tamaño según necesidad
            ),
          ),
        ),
      ],
    );
  }
}