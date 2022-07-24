import 'dart:convert';

import 'package:automobileservice/model/center_model.dart';
import 'package:automobileservice/model/service_model.dart';

class OrderModel {
  CenterModel? center;
  List<ServiceModel>? services;
  String? reportid;
  String? customerid;
  String? servicecenterid;
  String? payable;
  String? paymentstatus;
  String? status;

  OrderModel({
    this.center,
    this.services,
    this.customerid,
    this.payable,
    this.paymentstatus,
    this.reportid,
    this.servicecenterid,
    this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic>? json) {
    return OrderModel(
      center: CenterModel.fromJson(jsonDecode(json?['center'])),
      customerid: json?['customerid'],
      payable: json?['payable'],
      paymentstatus: json?['paymentstatus'],
      reportid: json?['reportid'],
      servicecenterid: json?['servicecenterid'],
      status: json?['status'],
      services: jsonDecode(json?['services'])
          .map<ServiceModel>((e) => ServiceModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'center': center?.toJson(),
      'customerid': customerid,
      'payable': payable,
      'paymentstatus': paymentstatus,
      'reportid': reportid,
      'servicecenterid': servicecenterid,
      'status': status,
      'services': services?.map((e) => e.toJson()).toList(),
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
