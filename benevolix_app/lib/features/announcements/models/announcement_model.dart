import 'package:benevolix_app/features/announcements/models/tag_model.dart';
import 'package:benevolix_app/features/candidacies/models/candidacy_model.dart';

class Announcement {
  final int id;
  final String adress;
  final List<Candidacy> application;
  final String date;
  final String description;
  final int duration;
  final bool isRemote;
  final List<Tag> tags;
  final String title;
  final int ownerId;
  final String ownerFirstname;
  final String ownerLastname;

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
    required this.ownerId,
    required this.ownerFirstname,
    required this.ownerLastname,
  });

  //transformation en Announcement
  factory  Announcement.fromJson(Map<String, dynamic> json) {
    List<Candidacy> listCandidacies = [];
    List<Tag> listTags = [];

    // Vérifie si la liste de candidature json est pas vide puis la transforme en liste de tag
    if (json['candidatures'] != null && json['candidatures'] is List) {
      listCandidacies = (json['candidatures'] as List).map((candidature) => Candidacy.fromJson(candidature)).toList();
    }

    // Vérifie si la liste de tag json est pas vide puis la transforme en liste de tag
    if (json['tags'] != null && json['tags'] is List) {
      listTags = (json['tags'] as List).map((tag) => Tag.fromJson(tag)).toList();
    }

    var owner = json['owner'];

    return Announcement(
      id: json['id'] ?? 0,
      adress: json['address'] ?? '',
      application: listCandidacies,
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0,
      date: json['date'] ?? '',
      isRemote: json['is_remote'] ?? false,
      tags: listTags,
      title: json['title'] ?? '',
      ownerId: owner['id'] ?? 0,
      ownerFirstname: owner['first_name'] ?? "",
      ownerLastname: owner['last_name'] ?? "",
    );
  }

  //transformation en json
  Map<String, dynamic> toJson() {
    return {
      'adress': adress,
      'candidatures': application,
      'description': description,
      'duration': duration,
      'is_remote': isRemote,
      'tags': tags,
      'title': title,
      'owner_id' : ownerId,
    };
  }
}