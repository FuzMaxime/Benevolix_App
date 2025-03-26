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
    await _saveToken(data["token"], data["userId"]);
    return true;
  } else {
    return false;
  }
}

Future<bool> register(String email, String password, String firstName,
    String lastName, String phone) async {
  final response = await http.post(
    Uri.parse("$apiUrl/users"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "phone": phone,
      "city": "Nantes",
      "bio": "bio",
      "Tags": []
    }),
  );

  return response.statusCode == 200;
}

Future<bool> isAuthenticated() async {
  String? token = await _getToken();
  if (token == null) return false;

  final response = await http.get(
    Uri.parse("$apiUrl/auth/protected"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  return response.statusCode == 200;
}

Future<void> logout() async {
  await _removeToken();
}

Future<void> _saveToken(String token, int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("auth_token", token);
  await prefs.setString("user_id", userId.toString());
}

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("auth_token");
}

Future<String?> _getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("user_id");
}

Future<void> _removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("auth_token");
  await prefs.remove("user_id");
}
