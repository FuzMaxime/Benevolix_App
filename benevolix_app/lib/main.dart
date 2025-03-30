import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/pages/generic_page.dart';
import 'package:benevolix_app/pages/login.dart';
import 'package:benevolix_app/pages/profile.dart';
import 'package:benevolix_app/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/home.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benevolix',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => GenericPage(HomePage()),
        '/profile': (context) => GenericPage(ProfilePage())
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: ColorConstant.white,
        fontFamily: 'Poppins',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorConstant.white,
        ),
      ),
    );
  }
}
