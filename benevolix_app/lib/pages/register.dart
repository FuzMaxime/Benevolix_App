import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/constants/decoration.dart';
import 'package:benevolix_app/services/auth.dart';
import 'package:benevolix_app/widgets/header_auth.dart';
import 'package:benevolix_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isLoading = false; // Indicates if the registration process is ongoing
  String? errorMessage; // Stores any error message to display

  // Method to handle the registration process
  void _handleRegister() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // Attempt to register using the provided user details
    bool success = await register(
        emailController.text,
        passwordController.text,
        firstNameController.text,
        lastNameController.text,
        phoneController.text);

    setState(() {
      isLoading = false;
    });

    if (success) {
      // Navigate to the login page if registration is successful
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      // Display an error message if registration fails
      setState(() {
        errorMessage = "Registration failed. Please try again.";
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
              HeaderAuth(title: "Create an Account"), // Header for the registration page
              Column(
                spacing: 30.0,
                children: [
                  TextField(
                      controller: emailController,
                      decoration: getInputDecoration('Email')), // Input field for email
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
                    controller: phoneController,
                    decoration: getInputDecoration('Phone number'),
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
                      isLoading: isLoading), // Button to initiate the registration process
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login'); // Navigate to the login page
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
