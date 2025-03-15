import 'package:benevolix_app/widgets/headerAuth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final String title;

  const Login({super.key, required this.title});

  void handleLogin(String taskName) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.all(25.0),
      child: Center(
        child: Column(
          children: [
            HeaderAuth(title: "Create an account"),
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
