class DoctorModel {
  String id;
  String name;
  String email;
  String username;

  DoctorModel({
    this.id,
    this.name,
    this.email,
    this.username,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> data) {
    return DoctorModel(
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
