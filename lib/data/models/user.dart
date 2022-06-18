class UserEntity {
  int id;
  String fullName;
  String email;
  String role;
  String? profilePhoto;
  String password;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    this.profilePhoto,
    required this.password,
  });
}
