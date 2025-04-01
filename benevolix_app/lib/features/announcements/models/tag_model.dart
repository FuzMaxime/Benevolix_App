class Tag {
  final int? id;
  final String name;

  Tag({
    this.id,
    required this.name,
  });
  //Transformation en Tag
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  //Transformation en Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}