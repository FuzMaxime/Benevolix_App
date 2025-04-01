import 'dart:io';

import 'package:benevolix_app/features/announcements/models/announcement_model.dart';
import 'package:benevolix_app/features/announcements/services/annoucement_service.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';
import '../../auth/services/permission_service.dart';
import '../../announcements/widgets/details_announcement_widget.dart';
import '../../location/services/location_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Announcement> allAnnouncements = [];
  List<Announcement> filteredAnnouncements = [];

  LocationService locationService = LocationService();

  String titleFilter = "";
  String locationFilter = "";
  String? _address;

  @override
  void initState() {
    super.initState();
    loadAnnouncements();
    _initializeLocation();
  }


  Future<void> _initializeLocation() async {
    // Gérer les permissions de localisation
    bool locationPermissionStatus = await manageLocationPermission();
    if (locationPermissionStatus) {
      // Récupérer l'adresse uniquement si les permissions sont accordées
      await _fetchAddress();
    } else {
      setState(() {
        _address = "Permissions de localisation refusées.";
      });
    }
  }

  Future<bool> manageLocationPermission() async {
    bool locationPermissionStatus = await checkPermissionStatus();
    if (!locationPermissionStatus) {
      locationPermissionStatus = await requestPermission();
    }
    return locationPermissionStatus;
  }

  Future<void> _fetchAddress() async {
    final locationService = LocationService();
    final address = await locationService.getAddressFromLatLng();
    setState(() {
      _address = address;
      locationFilter = address ?? "";
    });
    filterAnnouncements();
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
              const SizedBox(height: 30),
              buildLabel("Quoi ?"),
              buildSearchField("Rechercher une annonce", (value) {
                setState(() {
                  titleFilter = value;
                  filterAnnouncements();
                });
              }),
              const SizedBox(height: 5),
              buildLabel("Où ?"),
              buildSearchField( _address ?? "Ville", (value) {
                setState(() {
                  locationFilter = value;
                  _address = value;
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
