class DoctorModel {
  String id;
  String name;
  String email;
  String username;
  double rate;
  String phoneNumber;
  String workSpace;
  String token;

  DoctorModel(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.rate,
      this.phoneNumber,
      this.workSpace,
      this.token});

  factory DoctorModel.fromMap(Map<String, dynamic> data) {
    return DoctorModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      username: data['username'],
      rate: data['rate'],
      phoneNumber: data['phoneNumber'],
      workSpace: data['workSpace'],
      token: data['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'rate': rate,
      'phoneNumber': phoneNumber,
      'workSpace': workSpace,
      'token': token,
    };
  }
}
