
class User {
  final int id;
  final String email;
  final String username;
  final String? fullName;
  final String? profilePicture;
  final bool isAdmin;

  User({
    required this.id,
    required this.email,
    required this.username,
    this.fullName,
    this.profilePicture,
    this.isAdmin = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      fullName: json['full_name'],
      profilePicture: json['profile_picture'],
      isAdmin: json['is_admin'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'full_name': fullName,
      'profile_picture': profilePicture,
      'is_admin': isAdmin,
    };
  }
}
