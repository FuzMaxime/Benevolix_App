import 'package:benevolix_app/features/auth/services/auth_service.dart';
import 'package:benevolix_app/features/auth/widgets/header_auth_widget.dart';
import 'package:benevolix_app/core/widgets/submit_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';
import '../../../core/constants/decoration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  void _handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    bool success = await login(emailController.text, passwordController.text);

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        errorMessage = "Email ou mot de passe invalide.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            spacing: 50.0,
            children: [
              HeaderAuth(title: "Content de vous revoir !"),
              Column(
                spacing: 35.0,
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: getInputDecoration('Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: getInputDecoration('Mot de passe'),
                  ),
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: TextStyle(color: ColorConstant.red),
                    ),
                  const SizedBox(height: 4),
                  SubmitButton(
                      text: 'Se connecter',
                      onPressed: _handleLogin,
                      isLoading: isLoading),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Vous n'avez pas de compte ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text("S'inscrire",
                              style: TextStyle(color: ColorConstant.red)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
