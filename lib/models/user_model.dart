class UserModel {
  const UserModel({
    required this.name,
    required this.email,
    this.role = 'user',
  });

  final String name;
  final String email;
  final String role;
}
