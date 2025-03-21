import 'package:billbreaker_admin/app/authentication/auth_service.dart';
import 'package:billbreaker_admin/app/pages/register/register_controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends GetView<RegisterController> {
  RegisterPage({super.key});

  final TextEditingController _emailRegisterController = TextEditingController();
  final TextEditingController _passwordRegisterController = TextEditingController();
  final TextEditingController _emailVerifyController = TextEditingController();
  final TextEditingController _passwordVerifyController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  void _register(BuildContext context) async {
    // Check if emails match
    if (_emailRegisterController.text != _emailVerifyController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Los correos electrónicos no coinciden'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Exit the method if emails don't match
    }

    // Check if passwords match
    if (_passwordRegisterController.text != _passwordVerifyController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Las contraseñas no coinciden'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Exit the method if passwords don't match
    }

    // Proceed with registration if validation passes
    await AuthService().register(
      _userNameController.text,
      _emailRegisterController.text,
      _emailVerifyController.text,
      _passwordRegisterController.text,
      _passwordVerifyController.text,
    );

    if (context.mounted) {
      GoRouter.of(context).go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: 300, // Ancho del contenedor
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Registrarse',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Campo de usuario
              TextField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person), // Changed to a more appropriate icon
                ),
              ),
              const SizedBox(height: 20),
              // Campo de correo
              TextField(
                controller: _emailRegisterController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              // Campo de verificar correo
              TextField(
                controller: _emailVerifyController,
                decoration: const InputDecoration(
                  labelText: 'Verificar correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              // Campo de contraseña
              TextField(
                controller: _passwordRegisterController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 15),
              // Campo de verificar contraseña
              TextField(
                controller: _passwordVerifyController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Verificar contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 15),
              // Botón de Registro
              ElevatedButton(
                onPressed: () => _register(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Registrarse', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}