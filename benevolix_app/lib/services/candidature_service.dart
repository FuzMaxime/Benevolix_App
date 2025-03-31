import 'dart:convert';
import 'package:benevolix_app/services/auth.dart';
import 'package:http/http.dart' as http;

final String apiUrl = "http://localhost:8080/api/v1";

Future<int?> createCandidature(
    int annonceId,
    DateTime date,
    String status,
    int userId) async {
  final token = await getToken();

  final response = await http.post(
    Uri.parse("$apiUrl/candidature"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "user_id": userId,
      "annonce_id": annonceId,
      "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      "status": status,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data["id"];
  }
  return null;
}
