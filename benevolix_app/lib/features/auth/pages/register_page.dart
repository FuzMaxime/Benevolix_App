import 'package:benevolix_app/features/auth/services/auth_service.dart';
import 'package:benevolix_app/features/auth/widgets/header_auth_widget.dart';
import 'package:benevolix_app/core/widgets/submit_button_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';
import '../../../core/constants/decoration.dart';

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
        errorMessage = "L'inscription a échoué. Veuillez réessayer.";
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
            spacing: 25.0,
            children: [
              HeaderAuth(
                  title: "Créer un Compte"), // Header for the registration page
              Column(
                spacing: 20.0,
                children: [
                  TextField(
                      controller: emailController,
                      decoration:
                          getInputDecoration('Email')), // Input field for email
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: firstNameController,
                          decoration: getInputDecoration('Prénom'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: lastNameController,
                          decoration: getInputDecoration('Nom'),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: phoneController,
                    decoration: getInputDecoration('Numéro de téléphone'),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: getInputDecoration('Mot de passe'),
                  ),
                  if (errorMessage != null)
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  SubmitButton(
                      text: 'S\'inscrire',
                      onPressed: _handleRegister,
                      isLoading:
                          isLoading), // Button to initiate the registration process
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        1, // 90% de la largeur de l'écran
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 0,
                      children: [
                        Text("Vous avez déjà un compte ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            "Se connecter",
                            style: TextStyle(color: ColorConstant.red),
                          ),
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
