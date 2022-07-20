class ManagerModel {
  String? managerid;
  String? name;
  String? email;
  String? mobile;
  String? username;
  String? servicecenterid;
  String? image;
  String? password;
  String? role;
  ManagerModel({
    this.email,
    this.image,
    this.managerid,
    this.mobile,
    this.name,
    this.password,
    this.role,
    this.servicecenterid,
    this.username,
  });

  factory ManagerModel.fromJson(Map<String, dynamic>? json) {
    return ManagerModel(
      email: json?['email'],
      image: json?['image'],
      managerid: json?['managerid'],
      mobile: json?['mobile'],
      name: json?['name'],
      password: json?['password'],
      role: json?['role'],
      servicecenterid: json?['servicecenterid'],
      username: json?['username'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'email': email,
      'image': image,
      'managerid': managerid,
      'mobile': mobile,
      'name': name,
      'password': password,
      'role': role,
      'servicecenterid': servicecenterid,
      'username': username,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
