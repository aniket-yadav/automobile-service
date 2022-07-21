import 'package:automobileservice/model/center_model.dart';

class CenterResponse {
  bool? success;
  String? message;
  List<CenterModel>? data;

  CenterResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CenterResponse.fromJson(Map<String, dynamic>? json) {
    return CenterResponse(
      success: json?['success'],
      message: json?['message'],
      data: json?['data']
          ?.map<CenterModel>((e) => CenterModel.fromJson(e))
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
