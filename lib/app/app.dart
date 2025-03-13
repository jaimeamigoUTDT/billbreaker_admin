import 'package:billbreaker_admin/app/pages/ajustes.dart';
import 'package:billbreaker_admin/app/pages/estadisticas.dart';
import 'package:billbreaker_admin/app/pages/historial.dart';
import 'package:billbreaker_admin/app/pages/integraciones.dart';
import 'package:billbreaker_admin/app/pages/login/login_view.dart';
import 'package:billbreaker_admin/app/pages/home.dart';
import 'package:billbreaker_admin/app/pages/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _router = GoRouter(
    initialLocation: '/home',
    routes: [
      _route('/home', HomePage()),
      _route('/historial', HistorialPage()),
      _route('/estadisticas', EstadisticasPage()),
      _route('/ajustes', AjustesPage()),
      _route('/integraciones', IntegracionesPage()),
      _route('/login', LoginPage()),
      _route('/register', RegisterPage()),
    ],
  );

  static GoRoute _route(String path, Widget page) => GoRoute(
        path: path,
        pageBuilder: (context, state) => NoTransitionPage(child: page),
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