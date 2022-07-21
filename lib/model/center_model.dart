class CenterModel {
  String? centerid;
  String? name;
  String? managerid;
  String? address;
  String? city;
  String? district;
  String? pincode;
  String? latitude;
  String? longitude;

  CenterModel({
    this.address,
    this.centerid,
    this.city,
    this.district,
    this.latitude,
    this.longitude,
    this.managerid,
    this.name,
    this.pincode,
  });

  factory CenterModel.fromJson(Map<String, dynamic>? json) {
    return CenterModel(
      address: json?['address'],
      centerid: json?['centerid'],
      city: json?['city'],
      district: json?['district'],
      latitude: json?['latitude'],
      longitude: json?['longitude'],
      managerid: json?['managerid'],
      name: json?['name'],
      pincode: json?['pincode'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'address': address,
      'centerid': centerid,
      'city': city,
      'district': district,
      'latitude': latitude,
      'longitude': longitude,
      'managerid': managerid,
      'name': name,
      'pincode': pincode,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
