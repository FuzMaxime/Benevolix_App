import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/constants/decoration.dart';
import 'package:benevolix_app/services/auth.dart';
import 'package:benevolix_app/widgets/header_auth.dart';
import 'package:benevolix_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  void _handleRegister() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    bool success = await register(
      emailController.text,
      passwordController.text,
      firstNameController.text,
      lastNameController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (success) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      setState(() {
        errorMessage = "Registration failed. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0),
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            spacing: 50.0,
            children: [
              HeaderAuth(title: "Create an Account"),
              Column(
                spacing: 30.0,
                children: [
                  TextField(
                      controller: emailController,
                      decoration: getInputDecoration('Email')),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: firstNameController,
                          decoration: getInputDecoration('First name'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: lastNameController,
                          decoration: getInputDecoration('Last name'),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: getInputDecoration('Password'),
                  ),
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  SubmitButton(
                      text: 'Register',
                      onPressed: _handleRegister,
                      isLoading: isLoading),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text("Login",
                              style: TextStyle(color: ColorConstant.red)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
