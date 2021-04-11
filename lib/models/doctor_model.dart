class DoctorModel {
  String id;
  String name;
  String email;
  String username;
  double rate;

  DoctorModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.rate,
  });

  factory DoctorModel.fromMap(Map<String, dynamic> data) {
    return DoctorModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      username: data['username'],
      rate: data['rate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'rate': rate,
    };
  }
}
