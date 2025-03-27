import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/constants/decoration.dart';
import 'package:benevolix_app/services/auth.dart';
import 'package:benevolix_app/widgets/header_auth.dart';
import 'package:benevolix_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginState createState() => _LoginState();
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
    print(success);
    if (success) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      setState(() {
        errorMessage = "Invalid email or password.";
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
              HeaderAuth(title: "Welcome Back!"),
              Column(
                spacing: 35.0,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: getInputDecoration('Email'),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: getInputDecoration('Password'),
                  ),
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: TextStyle(color: ColorConstant.red),
                    ),
                  const SizedBox(height: 4),
                  SubmitButton(
                      text: 'Sign in',
                      onPressed: _handleLogin,
                      isLoading: isLoading),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text("Register",
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
