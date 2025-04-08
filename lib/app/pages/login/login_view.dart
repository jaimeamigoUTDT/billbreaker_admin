import 'package:billbreaker_admin/app/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../authentication/auth_service.dart';
import 'package:billbreaker_admin/app/app.dart' as app;
import 'package:billbreaker_admin/app/pages/home/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final HomeController homeController = Get.find<HomeController>();

  void _login(BuildContext context) async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingresa tu correo electrónico'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingresa tu contraseña'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await AuthService().login(_emailController.text, _passwordController.text);
      if (app.isAuthenticated && context.mounted) {
        GoRouter.of(context).go('/home');
        homeController.getMesas();
      }
    } catch (e) {
      final errorMessage = e.toString().contains('Invalid login credentials')
          ? 'Correo o contraseña incorrectos'
          : 'Error al iniciar sesión: ${e.toString()}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    const double aspectRatio = 539 / 717;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth * 0.5;
          double height = width / aspectRatio;

          if (height > constraints.maxHeight * 0.9) {
            height = constraints.maxHeight * 0.9;
            width = height * aspectRatio;
          }

          final fieldWidth = width * (398 / 539);
          final fieldHeight = fieldWidth / (398 / 54);

          return Center(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 50),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SvgPicture.asset('assets/logobb.svg', height: 59),
                            const SizedBox(height: 21),

                            Text(
                              'Bienvenido',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            
                            Text(
                              'Iniciá sesión o crea una cuenta',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),

                            const SizedBox(height: 40),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Email',
                                style: GoogleFonts.manrope(fontSize: 16, color: Colors.grey[700]),
                              ),
                            ),
                            const SizedBox(height: 11),
                            Center(
                              child: SizedBox(
                                width: fieldWidth,
                                height: fieldHeight,
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    hintText: 'Ingresá tu mail...',
                                    hintStyle: GoogleFonts.manrope(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Contraseña',
                                  style: GoogleFonts.manrope(fontSize: 16, color: Colors.grey[700]),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(0, 0),
                                  ),
                                  child: Text(
                                    'Recuperar contraseña',
                                    style: GoogleFonts.manrope(fontSize: 12, color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                              const SizedBox(height: 11),
                            Center(
                              child: SizedBox(
                                width: fieldWidth,
                                height: fieldHeight,
                                child: TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Ingresá tu contraseña...',
                                    hintStyle: GoogleFonts.manrope(),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 22),
                            Center(
                              child: SizedBox(
                                width: fieldWidth,
                                height: fieldHeight,
                                child: ElevatedButton(
                                  onPressed: () => _login(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF6F4F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign in',
                                    style: GoogleFonts.manrope(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Footer
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDEDED),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No tenés cuenta? ',
                          style: GoogleFonts.manrope(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/register'),
                          child: Text(
                            'Registrate',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
