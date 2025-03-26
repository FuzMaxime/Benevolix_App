class Application {
  final int id;
  final int annoucementId;
  final String date;
  final String status;
  final int userId;

  Application({
    required this.id,
    required this.annoucementId,
    required this.date,
    required this.status,
    required this.userId,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] ?? 0,
      annoucementId: json['annonce_id'] ?? 0,
      date: json['date'] ?? '',
      status: json['status'] ?? '',
      userId: json['user_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'annonce_id': annoucementId,
      'date': date,
      'status': status,
      'user_id': userId,
    };
  }
}