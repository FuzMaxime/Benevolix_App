import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/constants/decoration.dart';
import 'package:benevolix_app/services/auth.dart';
import 'package:benevolix_app/widgets/header_auth.dart';
import 'package:benevolix_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false; // Indicates if the login process is ongoing
  String? errorMessage; // Stores any error message to display

  // Method to handle the login process
  void _handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Attempt to log in using the provided email and password
    bool success = await login(emailController.text, passwordController.text);

    setState(() {
      isLoading = false;
    });

    if (success) {
      // Navigate to the home page if login is successful
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Display an error message if login fails
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
              HeaderAuth(title: "Welcome Back!"), // Header for the login page
              Column(
                spacing: 35.0,
                children: [
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: getInputDecoration('Email'), // Input decoration for the email field
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: getInputDecoration('Password'), // Input decoration for the password field
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
                      isLoading: isLoading), // Button to initiate the login process
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register'); // Navigate to the registration page
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
