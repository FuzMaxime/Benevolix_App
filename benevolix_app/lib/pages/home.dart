import 'dart:io';

// Import necessary files for colors, models, services, and widgets
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
  List<Announcement> allAnnouncements = []; // List to store all fetched announcements
  List<Announcement> filteredAnnouncements = []; // List to store announcements after filtering

  String titleFilter = ""; // Filter for the title of the announcements
  String locationFilter = ""; // Filter for the location of the announcements

  @override
  void initState() {
    super.initState();
    loadAnnouncements(); // Load announcements when the widget is initialized
  }

  // Asynchronous method to load announcements from an external service
  Future<void> loadAnnouncements() async {
    try {
      List<Announcement> announcementsData = await getAllAnnoucement();
      setState(() {
        allAnnouncements = announcementsData;
        filteredAnnouncements = allAnnouncements; // Display all announcements by default
      });
    } catch (e) {
      // In case of an error, display an error message in the console
      stderr.writeln("Error loading announcements: $e");
    }
  }

  // Method to filter announcements based on title and location
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
              buildLabel("Quoi ?"), // Label for the title search field
              buildSearchField("Rechercher une annonce", (value) {
                setState(() {
                  titleFilter = value;
                  filterAnnouncements();
                });
              }),
              const SizedBox(height: 5),
              buildLabel("Où ?"), // Label for the location search field
              buildSearchField("Nantes", (value) {
                setState(() {
                  locationFilter = value;
                  filterAnnouncements();
                });
              }),
              const SizedBox(height: 20),

              // Display the filtered announcements
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

  // Method to create a label with the given text
  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Method to create a search field with a hint text and a callback function
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
