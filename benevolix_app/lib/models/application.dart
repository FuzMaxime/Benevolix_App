
class Application {
  final int annonceId;
  final String date;
  final String status;
  final String uniqueConstraint;
  final int userId;

  Application({
    required this.annonceId,
    required this.date,
    required this.status,
    required this.uniqueConstraint,
    required this.userId,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      annonceId: json['annonce_id'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      uniqueConstraint: json['uniqueConstraint'] ?? '',
      userId: json['user_id'] ?? 0,
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
