// lib/models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final String phone; // Add this field
  final String address; // Add this field

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.phone, // Add this parameter
    required this.address, // Add this parameter
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      phone: json['phone'], // Parse this field
      address: json['address'], // Parse this field
    );
  }
}

