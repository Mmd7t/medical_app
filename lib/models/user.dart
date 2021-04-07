class Users {
  String id;
  String name;
  String email;
  String username;

  Users({
    this.id,
    this.name,
    this.email,
    this.username,
  });

  factory Users.fromMap(Map<String, dynamic> data) {
    return Users(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      username: data['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
    };
  }
}
