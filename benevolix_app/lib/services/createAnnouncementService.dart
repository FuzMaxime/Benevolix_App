import 'dart:convert';

import 'package:benevolix_app/models/tag.dart';
import 'package:benevolix_app/utils/formatUtils.dart';
import 'package:http/http.dart' as http;
import 'auth.dart';

final String apiUrl = "http://localhost:8080/api/v1";

Future<Tag?> addTag(String tagName) async {
  final token = await getToken();

  final responseGet = await http.get(
    Uri.parse("$apiUrl/tags/$tagName"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  if (responseGet.statusCode == 200) {
    final data = jsonDecode(responseGet.body);
    if (data["name"] != null) {
      return Tag(name: data["name"], id: data["id"]);
    }
  }

  final responsePost = await http.post(
    Uri.parse("$apiUrl/tags"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({"name": tagName}),
  );

  if (responsePost.statusCode == 200) {
    final data = jsonDecode(responsePost.body);
    if (data["name"] != "") {
      return Tag(name: data["name"], id: data["id"]);
    }
  }

  return null;
}

Future<int?> createAnnouncement(
    String title,
    String description,
    DateTime date,
    int duration,
    String address,
    bool isRemote,
    Map<int, String> tags) async {
  final token = await getToken();

  final response = await http.post(
    Uri.parse("$apiUrl/annonces"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
    body: jsonEncode({
      "title": title,
      "description": description,
      "date": formatDate(date),
      "duration": duration,
      "address": address,
      "is_remote": isRemote,
      "tags": tags.keys.toList()
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data["id"];
  }
  return null;
}
