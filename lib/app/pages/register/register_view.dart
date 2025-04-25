import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:billbreaker_admin/app/authentication/auth_service.dart';
import 'dart:convert';

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
    final hasSpecialChar = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-=\[\];\/~`+]'));
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

    if (_userNameController.text.contains('-')) {
      setState(() => _usernameError = 'No se permiten guiones en el nombre de usuario.');
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

    try {
      final response = await AuthService().register(
        _userNameController.text,
        _emailRegisterController.text,
        _emailVerifyController.text,
        _passwordRegisterController.text,
        _passwordVerifyController.text,
      );

      final responseBody = jsonDecode(response.body);
      if (response.statusCode == 200 && responseBody['status'] == 'OK') {
        if (context.mounted) {
          GoRouter.of(context).go('/login');
        }
      } else {
        final errorMessage = responseBody['message'] ?? 'Error desconocido';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $errorMessage')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = 674 / 965;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double width = constraints.maxWidth * 0.5;
          double height = width / aspectRatio;

          if (height > constraints.maxHeight * 0.9) {
            height = constraints.maxHeight * 0.95;
            width = height * aspectRatio;
          }

          final double scaleFactor = width / 674.0;
          double scaled(double value) => value * scaleFactor;

          final fieldWidth = scaled(530);
          final fieldHeight = scaled(60);

          return Center(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(scaled(30)),
                border: Border.all(color: const Color(0xFF66666), width: scaled(2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: scaled(8),
                    offset: Offset(0, scaled(4)),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: scaled(70),
                        vertical: scaled(50),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SvgPicture.asset('assets/logobb.svg', height: scaled(75)),
                          SizedBox(height: scaled(20)),
                          Text(
                            'Registrate',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: scaled(50),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          //SizedBox(height: scaled(6)),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: GoogleFonts.manrope(
                                  fontSize: scaled(20),
                                  color: Colors.black87,
                                ),
                                children: [
                                  const TextSpan(text: '¿Ya tenés cuenta? '),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: GestureDetector(
                                      onTap: () => context.go('/login'),
                                      child: Text(
                                        'Iniciá sesión',
                                        style: GoogleFonts.manrope(
                                          fontSize: scaled(20),
                                          color: const Color(0xFFFE724C),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: scaled(24)),

                          _buildLabeledInput(
                            label: 'Nombre de usuario',
                            hint: 'Creá tu nombre de usuario',
                            controller: _userNameController,
                            errorText: _usernameError,
                            onChanged: (value) {
                              if (value.contains('_')) {
                                setState(() => _usernameError = 'No se permiten guiones bajos en el nombre de usuario.');
                              } else {
                                setState(() => _usernameError = null);
                              }
                            },
                            width: fieldWidth,
                            height: fieldHeight,
                          ),
                          SizedBox(height: scaled(16)),

                          _buildLabeledInput(
                            label: 'Email',
                            hint: 'Ingresá tu mail...',
                            controller: _emailRegisterController,
                            width: fieldWidth,
                            height: fieldHeight,
                          ),
                          SizedBox(height: scaled(16)),

                          _buildLabeledInput(
                            label: 'Verificar email',
                            hint: 'Re-ingresá tu mail...',
                            controller: _emailVerifyController,
                            width: fieldWidth,
                            height: fieldHeight,
                          ),
                          SizedBox(height: scaled(16)),

                          _buildLabeledInput(
                            label: 'Contraseña',
                            hint: 'Ingresá tu contraseña...',
                            controller: _passwordRegisterController,
                            obscureText: _obscurePassword,
                            errorText: _passwordError,
                            onChanged: (value) {
                              if (!_validatePassword(value)) {
                                setState(() => _passwordError = 'Debe tener al menos 8 caracteres,una mayúscula, una minúscula, un número y un símbolo.');
                              } else {
                                setState(() => _passwordError = null);
                              }
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                size: scaled(20),
                              ),
                              onPressed: () {
                                setState(() => _obscurePassword = !_obscurePassword);
                              },
                            ),
                            width: fieldWidth,
                            height: fieldHeight,
                          ),
                          SizedBox(height: scaled(16)),

                          _buildLabeledInput(
                            label: 'Repetir contraseña',
                            hint: 'Re-ingresá tu contraseña...',
                            controller: _passwordVerifyController,
                            obscureText: _obscureVerifyPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureVerifyPassword ? Icons.visibility : Icons.visibility_off,
                                size: scaled(20),
                              ),
                              onPressed: () {
                                setState(() => _obscureVerifyPassword = !_obscureVerifyPassword);
                              },
                            ),
                            width: fieldWidth,
                            height: fieldHeight,
                          ),

                          SizedBox(height: scaled(22)),
                          Center(
                            child: SizedBox(
                              width: fieldWidth,
                              height: fieldHeight,
                              child: ElevatedButton(
                                onPressed: () => _register(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF6F4F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(scaled(10)),
                                  ),
                                ),
                                child: Text(
                                  'Registrate',
                                  style: GoogleFonts.manrope(
                                    fontSize: scaled(20),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildLabeledInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    double? width,
    double? height,
    bool obscureText = false,
    Widget? suffixIcon,
    String? errorText,
    void Function(String)? onChanged,
  }) {
    final scaleFactor = width != null ? width / 398 : 1.0;
    double scaled(double value) => value * scaleFactor;

    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: scaled(16),
                fontWeight: FontWeight.w500,
                color: const Color(0xFF666666),
              ),
            ),
            SizedBox(height: scaled(6)),
            SizedBox(
              height: height,
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: GoogleFonts.manrope(
                    fontSize: scaled(16),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF666666),
                  ),
                  errorText: errorText,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(scaled(8))),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(scaled(10)),
                    borderSide: BorderSide(color: const Color(0xFF666666), width: scaled(1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(scaled(10)),
                    borderSide: BorderSide(color: const Color(0xFFFE724C), width: scaled(2)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  isDense: true,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: scaled(12)),
                    child: suffixIcon,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: scaled(12),
                    vertical: scaled(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
