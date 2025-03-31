import 'dart:convert';
import 'package:benevolix_app/services/auth.dart';
import 'package:benevolix_app/models/application.dart';
import 'package:http/http.dart' as http;

final String apiUrl = "http://localhost:8080/api/v1";

Future<Application?> createApplication(
    int annonceId,
    DateTime date,
    String status,
    int userId) async {
  final token = await getToken();

  final response = await http.post(
    Uri.parse("$apiUrl/candidatures"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "annonce_id": annonceId,
      "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      "status": status,
      "user_id": userId,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return Application.fromJson(data);
  } else {
    return jsonDecode(response.body);
  }
  return null;
}
