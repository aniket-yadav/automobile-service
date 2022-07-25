class User {
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? city;
  String? district;
  String? pincode;
  String? image;
  String? role;
  String? userid;
  String? servicecenterid;
  User({
    this.name,
    this.mobile,
    this.email,
    this.address,
    this.city,
    this.district,
    this.image,
    this.pincode,
    this.role,
    this.userid,
    this.servicecenterid,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      role: json?['role'],
      address: json?['address'],
      city: json?['city'],
      district: json?['district'],
      email: json?['email'],
      mobile: json?['mobile'],
      name: json?['name'],
      pincode: json?['pincode'],
      image: json?['image'],
      servicecenterid: json?['servicecenterid'],
      userid: json?['adminid'] ?? json?['customerid'] ?? json?['managerid'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'role': role,
      'address': address,
      'city': city,
      'district': district,
      'email': email,
      'mobile': mobile,
      'name': name,
      'image': image,
      'servicecenterid': servicecenterid,
      'userid': userid,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
