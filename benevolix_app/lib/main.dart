import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home.dart'; // Import correct de ta page home

void main() {
  print("Lancement de l'application..."); // Debug print
  runApp(
    const ProviderScope( // Ajout du ProviderScope pour Riverpod
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("Construction de MyApp..."); // Debug print

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(), // Appelle directement HomePage() ici !
    );
  }
}
