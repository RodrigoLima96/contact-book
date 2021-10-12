class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  const User(this.id, this.name, this.email, this.avatarUrl);

  factory User.fromJson(Map<String, dynamic> json) =>
      User(json['id'], json['name'], json['email'], json['']);
}
