class Users {
  String id;
  String name;
  String email;
  String username;
  String token;

  Users({
    this.id,
    this.name,
    this.email,
    this.username,
    this.token,
  });

  factory Users.fromMap(Map<String, dynamic> data) {
    return Users(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      username: data['username'],
      token: data['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'token': token,
    };
  }
}
