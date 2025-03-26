import 'dart:convert';
import 'package:benevolix_app/models/annoucement.dart';
import 'package:benevolix_app/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final String apiUrl = "http://localhost:8080/api/v1";

Future<List<Annoucement>> getAllAnnoucement() async {
  String? token = await getToken();
  if (token == null) return [];

  final response = await http.get(
    Uri.parse("$apiUrl/annonces"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<Annoucement> listAnnouncement = data.map((announcement) => Annoucement.fromJson(announcement)).toList();

    return listAnnouncement;
  } else {
    return [];
  }
}








