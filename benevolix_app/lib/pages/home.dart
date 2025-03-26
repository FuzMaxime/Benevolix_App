import 'package:benevolix_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Details_announcement.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: MainHeader(title: "title")),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: SizedBox(
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                buildLabel("Quoi ?"),
                buildSearchField("Rechercher une annonce"),
                const SizedBox(height: 5),
                buildLabel("Où ?"),
                buildSearchField("Nantes"),
                const SizedBox(height: 20),

                // Ajout de plusieurs annonces pour tester le scroll
                AnnoucementDetails(),
                const SizedBox(height: 16),
                AnnoucementDetails(),
                const SizedBox(height: 16),
                AnnoucementDetails(),
                const SizedBox(height: 16),
                AnnoucementDetails(),
              ],
            ),
          ))),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildSearchField(String hintText) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
