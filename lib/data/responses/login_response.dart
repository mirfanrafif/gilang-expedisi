class LoginResponse {
  LoginResponse({
    required this.accessToken,
    required this.user,
  });

  final String? accessToken;
  final User? user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json["access_token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }
}

class User {
  User({
    required this.isActive,
    required this.isTrash,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
    required this.fullName,
  });

  final bool? isActive;
  final bool? isTrash;
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? firstName;
  final dynamic lastName;
  final String? role;
  final String? email;
  final String? fullName;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      isActive: json["is_active"],
      isTrash: json["is_trash"],
      id: json["id"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      firstName: json["first_name"],
      lastName: json["last_name"],
      role: json["role"],
      email: json["email"],
      fullName: json["full_name"],
    );
  }
}
