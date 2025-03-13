import 'package:billbreaker_admin/app/pages/integraciones.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app/pages/home.dart';
import 'app/pages/historial.dart';
import 'app/pages/estadisticas.dart';
import 'app/pages/ajustes.dart';
import 'app/pages/mesas.dart';

var restaurante_id = "a593b953-caeb-4924-a3f9-23396d318790";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Definimos el enrutador con go_router
  final GoRouter _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) =>  HomePage(),
      pageBuilder: (context, state) => NoTransitionPage(child:  HomePage()),
    ),
    GoRoute(
      path: '/historial',
      builder: (context, state) => const HistorialPage(),
      pageBuilder: (context, state) => NoTransitionPage(child: const HistorialPage()),
    ),
    GoRoute(
      path: '/estadisticas',
      builder: (context, state) => const EstadisticasPage(),
      pageBuilder: (context, state) => NoTransitionPage(child: const EstadisticasPage()),
    ),
    GoRoute(
      path: '/ajustes',
      builder: (context, state) => const AjustesPage(),
      pageBuilder: (context, state) => NoTransitionPage(child: const AjustesPage()),
    ),
    GoRoute(
      path: '/integraciones',
      builder: (context, state) => const IntegracionesPage(),
      pageBuilder: (context, state) => NoTransitionPage(child: const IntegracionesPage()),
    ),
    GoRoute(
        path: '/mesa/:pageNumber',
        builder: (context, state) {
          final pageNumber = state.pathParameters['pageNumber'] ?? '0';
          return MesaPage(restaurantId: restaurante_id, tableNumber: pageNumber);
        },
      ),
  ],
);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      routerConfig: _router,
      debugShowCheckedModeBanner: false, 
    );
  }
}
