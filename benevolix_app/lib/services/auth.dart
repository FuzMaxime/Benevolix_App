import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final String apiUrl = "http://localhost:8080/api/v1";

Future<bool> login(String email, String password) async {
  final response = await http.post(
    Uri.parse("$apiUrl/auth"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final token = data["token"];
    await _saveToken(token);
    return true;
  } else {
    return false;
  }
}

Future<bool> register(
    String email, String password, String firstName, String lastName) async {
  final response = await http.post(
    Uri.parse("$apiUrl/users"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "FirstName": firstName,
      "LastName": lastName,
      "Email": email,
      "Password": password,
      "Phone": "0000000000",
      "City": "City",
      "Bio": "Bio",
      "Tags": []
    }),
  );
  print(response.statusCode);

  return response.statusCode == 200;
}

Future<bool> isAuthenticated() async {
  String? token = await _getToken();
  if (token == null) return false;

  // Vérifie avec le backend si le token est encore valide
  final response = await http.get(
    Uri.parse("$apiUrl/auth/protected"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  return response.statusCode == 200; // 200 = Token valide
}

Future<void> logout() async {
  await _removeToken();
}

Future<void> _saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("auth_token", token);
}

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("auth_token");
}

Future<void> _removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("auth_token");
}
