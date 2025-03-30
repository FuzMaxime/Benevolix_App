import 'dart:io';

import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/models/announcement.dart';
import 'package:benevolix_app/services/annoucement_service.dart';
import 'package:flutter/material.dart';
import 'details_announcement.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Announcement> allAnnouncements = []; // Liste complète
  List<Announcement> filteredAnnouncements = []; // Liste filtrée

  String titleFilter = ""; // Filtrage par titre
  String locationFilter = ""; // Filtrage par ville

  @override
  void initState() {
    super.initState();
    loadAnnouncements();
  }

  Future<void> loadAnnouncements() async {
    try {
      List<Announcement> announcementsData = await getAllAnnoucement();
      setState(() {
        allAnnouncements = announcementsData;
        filteredAnnouncements = allAnnouncements; // Afficher tout par défaut
      });
    } catch (e) {
      stderr.writeln("Erreur lors du chargement des annonces : $e");
    }
  }

  void filterAnnouncements() {
    setState(() {
      filteredAnnouncements = allAnnouncements.where((annonce) {
        final matchesTitle = annonce.title.toLowerCase().contains(titleFilter.toLowerCase());
        final matchesLocation = annonce.adress.toLowerCase().contains(locationFilter.toLowerCase());
        return matchesTitle && matchesLocation;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              buildLabel("Quoi ?"),
              buildSearchField("Rechercher une annonce", (value) {
                setState(() {
                  titleFilter = value;
                  filterAnnouncements();
                });
              }),
              const SizedBox(height: 5),
              buildLabel("Où ?"),
              buildSearchField("Nantes", (value) {
                setState(() {
                  locationFilter = value;
                  filterAnnouncements();
                });
              }),
              const SizedBox(height: 20),

              // Affichage des annonces filtrées
              Column(
                children: filteredAnnouncements
                    .map((annonce) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AnnouncementDetails(announcement: annonce),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
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

  Widget buildSearchField(String hintText, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ColorConstant.grey),
        ),
        filled: true,
        fillColor: ColorConstant.white,
      ),
    );
  }
}
