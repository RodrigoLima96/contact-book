class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> parsedJson, id) {
    return User(
        id: id,
        name: parsedJson['name'],
        email: parsedJson['email'],
        avatarUrl: parsedJson['avatarUrl']);
  }
}
