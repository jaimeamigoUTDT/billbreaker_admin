import 'package:billbreaker_admin/pages/integraciones.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home.dart';
import 'pages/historial.dart';
import 'pages/estadisticas.dart';
import 'pages/ajustes.dart';

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
  ],
);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      routerConfig: _router,
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de "debug"
    );
  }
}
