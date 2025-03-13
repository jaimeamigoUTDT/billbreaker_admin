import 'package:billbreaker_admin/app/pages/ajustes/ajustes.dart';
import 'package:billbreaker_admin/app/pages/estadisticas/estadisticas.dart';
import 'package:billbreaker_admin/app/pages/historial/historial.dart';
import 'package:billbreaker_admin/app/pages/integraciones/integraciones.dart';
import 'package:billbreaker_admin/app/pages/login/login_view.dart';
import 'package:billbreaker_admin/app/pages/home/home.dart';
import 'package:billbreaker_admin/app/pages/mesas/mesas_view.dart';
import 'package:billbreaker_admin/app/pages/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'authentication/auth_service.dart';

late var restaurante_id;

class BillbreakerAdminDashboard extends StatelessWidget {
  const BillbreakerAdminDashboard({super.key});

  static GoRoute _route(String path, Widget page) => GoRoute(
    path: path,
    pageBuilder: (context, state) => NoTransitionPage(child: page),
  );

  static final _publicRoutes = [
    _route('/login', LoginPage()),
    _route('/register', RegisterPage()),
  ];

  static final _protectedRoutes = [
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => NoTransitionPage(child: HomePage()),
      redirect: (context, state) async {
        final authService = AuthService();
        if (!authService.isAuthenticated) {
          return '/login';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/historial',
      pageBuilder: (context, state) => NoTransitionPage(child: HistorialPage()),
      redirect: (context, state) async {
        final authService = AuthService();
        if (!authService.isAuthenticated) {
          return '/login';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/estadisticas',
      pageBuilder: (context, state) => NoTransitionPage(child: EstadisticasPage()),
      redirect: (context, state) async {
        final authService = AuthService();
        if (!authService.isAuthenticated) {
          return '/login';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/ajustes',
      pageBuilder: (context, state) => NoTransitionPage(child: AjustesPage()),
      redirect: (context, state) async {
        final authService = AuthService();
        if (!authService.isAuthenticated) {
          return '/login';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/integraciones',
      pageBuilder: (context, state) => NoTransitionPage(child: IntegracionesPage()),
      redirect: (context, state) async {
        final authService = AuthService();
        if (!authService.isAuthenticated) {
          return '/login';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/mesa/:pageNumber',
      builder: (context, state) {
        final pageNumber = state.pathParameters['pageNumber'] ?? '0';
        return MesaPage(restaurantId: restaurante_id, tableNumber: pageNumber);
      },
      redirect: (context, state) async {
        final authService = AuthService();
        if (!authService.isAuthenticated) {
          return '/login';
        }
        return null;
      },
    ),
  ];

  static final _router = GoRouter(
    initialLocation: '/login',
    routes: [
      ..._publicRoutes,
      ..._protectedRoutes,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Billbreakar Admin Dashboard',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}