import 'dart:convert';
import 'package:benevolix_app/features/announcements/models/announcement_model.dart';
import 'package:benevolix_app/features/auth/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = "${dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1"}/annonces";

//Récupérer toutes les annonces
Future<List<Announcement>> getAllAnnoucement() async {
  final token = await getToken();
  if (token == null) return [];

  final response = await http.get(
    Uri.parse(baseUrl),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Announcement> listAnnouncement =
        data.map((json) => Announcement.fromJson(json)).toList();
    return listAnnouncement;
  } else {
    return [];
  }
}

//Récupérer une annonce par son Id
Future<Announcement?> getAnnouncementById(int id) async {
  final token = await getToken();
  if (token == null) return null;

  final response = await http.get(
    Uri.parse("$baseUrl/$id"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    Announcement announcement = Announcement.fromJson(data);
    return announcement;
  } else {
    return null;
  }
}