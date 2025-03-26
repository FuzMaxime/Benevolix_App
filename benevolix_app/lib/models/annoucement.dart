import 'package:benevolix_app/models/application.dart' show Application;
import 'package:benevolix_app/models/tag.dart';

class Annoucement {
  final int id;
  final String adress;
  final List<Application> application;
  final String date;
  final String description;
  final int duration;
  final bool isRemote;
  final List<Tag> tags;
  final String title;

  Annoucement({
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

  factory Annoucement.fromJson(Map<String, dynamic> json) {
    return Annoucement(
      id: json['id'] ?? 0,
      adress: json['address'] ?? '',
      application: json['candidatures'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0,
      date: json['date'] ?? '',
      isRemote: json['is_remote'] ?? false,
      tags: json['tags'] ?? '',
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