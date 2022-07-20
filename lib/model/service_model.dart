class ServiceModel {
  String? serviceid;
  String? name;
  String? charge;
  ServiceModel({
    this.name,this.charge,this.serviceid,
  });

  factory ServiceModel.fromJson(Map<String, dynamic>? json) {
    return ServiceModel(
      charge: json?['charge'],
      name: json?['name'],
      serviceid: json?['serviceid'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'charge': charge,
      'name': name,
      'serviceid': serviceid,
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
