import 'package:automobileservice/model/service_model.dart';

class ServicesResponse {
  bool? success;
  String? message;
  List<ServiceModel>? data;

  ServicesResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ServicesResponse.fromJson(Map<String, dynamic>? json) {
    return ServicesResponse(
      success: json?['success'],
      message: json?['message'],
      data: json?['data']
          ?.map<ServiceModel>((e) => ServiceModel.fromJson(e))
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
