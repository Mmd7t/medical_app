class Users {
  String id;
  String name;
  String email;
  String phoneNum;

  Users({
    this.id,
    this.name,
    this.email,
    this.phoneNum,
  });

  factory Users.fromMap(Map<String, dynamic> data) {
    return Users(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      phoneNum: data['phoneNum'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNum': phoneNum,
    };
  }
}
