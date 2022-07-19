import 'package:automobileservice/model/customer_mode.dart';

class CustomersResponse {
  bool? success;
  String? message;
  List<CustomerModel>? data;

  CustomersResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CustomersResponse.fromJson(Map<String, dynamic>? json) {
    return CustomersResponse(
      success: json?['success'],
      message: json?['message'],
      data: json?['data']
          ?.map<CustomerModel>((e) => CustomerModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'success': success,
      'message': message,
      'data': data?.map((e) => e.toJson()).toList(),
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
