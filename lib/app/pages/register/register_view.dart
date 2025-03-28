import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:billbreaker_admin/app/authentication/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailRegisterController = TextEditingController();
  final TextEditingController _passwordRegisterController = TextEditingController();
  final TextEditingController _emailVerifyController = TextEditingController();
  final TextEditingController _passwordVerifyController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  String? _usernameError;
  String? _passwordError;

  bool _obscurePassword = true;
  bool _obscureVerifyPassword = true;

  bool _validatePassword(String password) {
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'\d'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_\-=\[\];\/~`+]'));
    final hasMinLength = password.length >= 8;

    return hasUppercase && hasLowercase && hasDigit && hasSpecialChar && hasMinLength;
  }

  void _trimControllers() {
    _userNameController.text = _userNameController.text.trim();
    _emailRegisterController.text = _emailRegisterController.text.trim();
    _emailVerifyController.text = _emailVerifyController.text.trim();
    _passwordRegisterController.text = _passwordRegisterController.text.trim();
    _passwordVerifyController.text = _passwordVerifyController.text.trim();
  }

  void _register(BuildContext context) async {
    _trimControllers();

    setState(() {
      _usernameError = null;
      _passwordError = null;
    });

    if (_userNameController.text.contains('_')) {
      setState(() => _usernameError = 'No se permiten guiones bajos en el nombre de usuario.');
      return;
    }

    if (_emailRegisterController.text != _emailVerifyController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Los correos electrónicos no coinciden'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_passwordRegisterController.text != _passwordVerifyController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Las contraseñas no coinciden'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_validatePassword(_passwordRegisterController.text)) {
      setState(() => _passwordError =
          'La contraseña debe tener al menos 8 caracteres,\nuna mayúscula, una minúscula, un número y un símbolo.');
      return;
    }

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
          width: 300,
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
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person),
                  errorText: _usernameError,
                  errorMaxLines: 2,
                ),
                onChanged: (value) {
                  if (value.contains('_')) {
                    setState(() => _usernameError =
                        'No se permiten guiones bajos en el nombre de usuario.');
                  } else {
                    setState(() => _usernameError = null);
                  }
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailRegisterController,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _emailVerifyController,
                decoration: const InputDecoration(
                  labelText: 'Verificar correo electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordRegisterController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  errorText: _passwordError,
                  errorMaxLines: 3,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  if (!_validatePassword(value)) {
                    setState(() => _passwordError =
                        'Debe tener al menos 8 caracteres,\nuna mayúscula, una minúscula, un número y un símbolo.');
                  } else {
                    setState(() => _passwordError = null);
                  }
                },
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordVerifyController,
                obscureText: _obscureVerifyPassword,
                decoration: InputDecoration(
                  labelText: 'Verificar contraseña',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureVerifyPassword ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscureVerifyPassword = !_obscureVerifyPassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
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
