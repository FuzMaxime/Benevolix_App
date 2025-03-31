
import 'package:benevolix_app/models/user.dart';

class Application {
  final int annonceId;
  final String date;
  final String status;
  final String uniqueConstraint;
  final int userId;
  final List<User> users;

  Application({
    required this.annonceId,
    required this.date,
    required this.status,
    required this.uniqueConstraint,
    required this.userId,
    required this.users
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    List<User> listUsers = [];

    if (json['user'] != null && json['user'] is List) {
      listUsers = (json['user'] as List).map((user) => User.fromJson(user)).toList();
    }

    return Application(
      annonceId: json['annonce'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      uniqueConstraint: json['uniqueConstraint'] ?? '',
      userId: json['userid'] ?? 0,
      users: listUsers ?? []
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'annonce_id': annonceId,
      'date': date,
      'status': status,
      'uniqueConstraint': uniqueConstraint,
      'user_id': userId,
    };
  }
}
