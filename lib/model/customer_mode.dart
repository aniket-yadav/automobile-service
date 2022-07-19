class CustomerModel {
  String? customerid;
  String? name;
  String? username;
  String? email;
  String? mobile;
  String? address;
  String? city;
  String? district;
  String? pincode;
  String? latitude;
  String? longitude;
  String? fcmtoken;
  String? image;
  String? password;
  String? role;
  CustomerModel({
    this.address,
    this.city,
    this.customerid,
    this.district,
    this.email,
    this.fcmtoken,
    this.image,
    this.latitude,
    this.longitude,
    this.mobile,
    this.name,
    this.password,
    this.pincode,
    this.role,
    this.username,
  });

  factory CustomerModel.fromJson(Map<String, dynamic>? json) {
    return CustomerModel(
      address: json?['address'],
      city: json?['city'],
      customerid: json?['customerid'],
      district: json?['district'],
      email: json?['email'],
      fcmtoken: json?['fcmtoken'],
      image: json?['image'],
      latitude: json?['latitude'],
      longitude: json?['longitude'],
      mobile: json?['mobile'],
      name: json?['name'],
      password: json?['password'],
      pincode: json?['pincode'],
      role: json?['role'],
      username: json?['username'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'address': address,
      'city': city,
      'customerid': customerid,
      'district': district,
      'email': email,
      'fcmtoken': fcmtoken,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'mobile': mobile,
      'name': name,
      'password': password,
      'pincode': pincode,
      'role': role,
      'username': username,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
