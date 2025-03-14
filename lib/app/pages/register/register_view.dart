import 'package:billbreaker_admin/app/authentication/auth_service.dart';
import 'package:billbreaker_admin/app/pages/register/register_controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends GetView<RegisterController> {
  RegisterPage({super.key});

  final TextEditingController _emailRegisterController = TextEditingController();
  final TextEditingController _passwordRegisterController = TextEditingController();

  void _register(BuildContext context) async {

    await AuthService().register(_emailRegisterController.text, _passwordRegisterController.text);

      if (context.mounted){
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
                'Iniciar Sesión',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Campo de correo
              TextField(
                controller: _emailRegisterController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              // Campo de contraseña
              TextField(
                controller: _passwordRegisterController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),
              // Botón de Login
              ElevatedButton(
                onPressed: () => {
                  _register(context)
                },
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