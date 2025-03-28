import 'package:benevolix_app/models/application.dart' show Application;
import 'package:benevolix_app/models/tag.dart';

class Announcement {
  final int id;
  final String adress;
  final List<Application> application;
  final String date;
  final String description;
  final int duration;
  final bool isRemote;
  final List<Tag> tags;
  final String title;

  Announcement({
    required this.id,
    required this.adress,
    required this.application,
    required this.date,
    required this.description,
    required this.duration,
    required this.isRemote,
    required this.tags,
    required this.title,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    List<Application> listApplications = [];
    List<Tag> listTags = [];

    // Vérifie si la liste de candidature json est pas vide puis la transforme en liste de tag
    if (json['candidatures'] != null && json['candidatures'] is List) {
      listApplications = (json['candidatures'] as List).map((candidature) => Application.fromJson(candidature)).toList();
    }

    // Vérifie si la liste de tag json est pas vide puis la transforme en liste de tag
    if (json['tags'] != null && json['tags'] is List) {
      listTags = (json['tags'] as List).map((tag) => Tag.fromJson(tag)).toList();
    }

    return Announcement(
      id: json['id'] ?? 0,
      adress: json['address'] ?? '',
      application: listApplications,
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0,
      date: json['date'] ?? '',
      isRemote: json['is_remote'] ?? false,
      tags: listTags,
      title: json['title'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adress': adress,
      'candidatures': application,
      'description': description,
      'duration': duration,
      'is_remote': isRemote,
      'tags': tags,
      'title': title,
    };
  }
}