import 'dart:convert';

import 'package:benevolix_app/models/user.dart';
import 'package:http/http.dart' as http;

final String baseUrl = "http://localhost:8080/api/v1/users";

class UserService {

  
  Future<User> getUser(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/$id"));
    if (response.statusCode == 200) {
      return User.fromJson(jsonEncode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to load user");
    }
  }

  Future<User> updateUser(String id, User user) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update user");
    }
  }

  Future<User> updatePassword(String id, String password) async {
    final response = await http.put(
      Uri.parse("$baseUrl/$id/password"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"password": password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update password");
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));

    if (response.statusCode != 204) {
      throw Exception("Failed to delete user");
    }
  }
}