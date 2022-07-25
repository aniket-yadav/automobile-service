import 'package:automobileservice/model/center_model.dart';

class MyCenterResponse {
  bool? success;
  String? message;
  CenterModel? data;

  MyCenterResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MyCenterResponse.fromJson(Map<String, dynamic>? json) {
    return MyCenterResponse(
      success: json?['success'],
      message: json?['message'],
      data:CenterModel.fromJson( json?['data'])
          ,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
