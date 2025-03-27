import 'dart:convert';

import 'package:benevolix_app/models/user.dart';
import 'package:benevolix_app/services/auth.dart';
import 'package:http/http.dart' as http;

final String baseUrl = "http://localhost:8080/api/v1/users";

class UserService {
  /*
  * This method is used to get the user details from the server
  * @param id: The id of the user
  * @return User: The user object
  * */
  Future<User> getUser(String id) async {
    final token = await getToken();
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['error'] ?? 'Failed to update user';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  /* 
  * This method is used to update the user details
  * @param id: The id of the user
  * @param user: The user object to be updated
  * @return User: The updated user object
  * */
  Future<User> updateUser(String id, User user) async {
    final token = await getToken();
    try {
      final response = await http.put(
        Uri.parse("$baseUrl/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['error'] ?? 'Failed to update user';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  /*
  * This method is used to update the user password
  * @param id: The id of the user
  * @param currentPassword: The current password
  * @param newPassword: The new password
  * @return User: The updated user object
  * */
  Future<User> updatePassword(
      String id, String currentPassword, String newPassword) async {
    final token = await getToken();

    try {
      if (currentPassword.isEmpty || newPassword.isEmpty) {
        throw 'Password cannot be empty';
      }
      if (currentPassword == newPassword) {
        throw 'New password cannot be the same as the current password';
      }

      final response = await http.put(
        Uri.parse("$baseUrl/$id/password"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(
            {"currentPassword": currentPassword, "newPassword": newPassword}),
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['error'] ?? 'Failed to update user';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  /*  
  * This method is used to delete the user
  * @param id: The id of the user
  * */
  Future<void> deleteUser(String id) async {
    final token = await getToken();
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode != 200) {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['error'] ?? 'Failed to update user';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
