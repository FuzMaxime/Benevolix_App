import 'dart:convert';
import 'package:benevolix_app/features/auth/services/auth_service.dart';
import 'package:benevolix_app/features/candidacies/models/candidacy_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = "${dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1"}/candidatures";

//Création de la candidature
Future<Candidacy?> createApplication(
    int annonceId,
    DateTime date,
    String status,
    int userId) async {
  final token = await getToken();

  final response = await http.post(
    Uri.parse(baseUrl),
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
    return Candidacy.fromJson(data);
  } else {
    return jsonDecode(response.body);
  }
}
