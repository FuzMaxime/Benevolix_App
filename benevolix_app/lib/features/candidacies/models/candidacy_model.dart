import '../../auth/models/user_model.dart';

class Candidacy {
  final int annonceId;
  final String date;
  final String status;
  final String uniqueConstraint;
  final int userId;
  final List<User> users;

  Candidacy({
    required this.annonceId,
    required this.date,
    required this.status,
    required this.uniqueConstraint,
    required this.userId,
    required this.users
  });

  //Transformation en Candidacy
  factory Candidacy.fromJson(Map<String, dynamic> json) {
    List<User> listUsers = [];

    if (json['user'] != null && json['user'] is List) {
      listUsers = (json['user'] as List).map((user) => User.fromJson(user)).toList();
    }

    return Candidacy(
      annonceId: json['annonce'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      uniqueConstraint: json['uniqueConstraint'] ?? '',
      userId: json['userid'] ?? 0,
      users: listUsers ?? []
    );
  }

  //Transformation en Json
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
