import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  //Récupération de la position actuelle de l'utilisateur
  Future<Position?> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return null;

    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  //Transformation en adresse utilisable par le front
  Future<String?> getAddressFromLatLng() async {
    try {
      final position = await _getCurrentPosition();
      if (position == null) return null;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        return placemark.locality;
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération de l'adresse : $e");
    }
    return null;
  }
}