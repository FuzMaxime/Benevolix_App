import 'dart:convert';
import 'package:benevolix_app/models/announcement.dart';
import 'package:benevolix_app/services/auth.dart';
import 'package:http/http.dart' as http;

final String apiUrl = "http://localhost:8080/api/v1";

Future<List<Announcement>> getAllAnnoucement() async {
  final token = await getToken();
  if (token == null) return [];

  final response = await http.get(
    Uri.parse("$apiUrl/annonces"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);

    List<Announcement> listAnnouncement =
        data.map((json) => Announcement.fromJson(json)).toList();

    return listAnnouncement;
  } else {
    return [];
  }
}








