import 'package:automobileservice/model/center_model.dart';
import 'package:automobileservice/model/service_model.dart';

class OrderModel {
  CenterModel? center;
  List<ServiceModel>? services;

  OrderModel({
    this.center,
    this.services,
  });

  factory OrderModel.fromJson(Map<String, dynamic>? json) {
    return OrderModel(
      center: CenterModel.fromJson(json?['center']),
      services: json?['services']
          ?.Map<ServiceModel>((e) => ServiceModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'center': center?.toJson(),
      'services': services?.map((e) => e.toJson()).toList(),
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
