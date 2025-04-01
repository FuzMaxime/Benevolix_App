class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? password;
  final String? phone;
  final String? city;
  final String? bio;
  final List<String>? tags;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.city,
    this.bio,
    this.password,
    this.tags,
  });

  //Transformation en User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      city: json['city'],
      bio: json['bio'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      password: json['password'],
    );
  }

  //Transformation en Json
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'city': city,
      'bio': bio,
      'tags': tags,
      'password': password,
    };
  }
}
