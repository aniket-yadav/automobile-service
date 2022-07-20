import 'package:automobileservice/model/manager_model.dart';

class ManagersResponse {
  bool? success;
  String? message;
  List<ManagerModel>? data;

  ManagersResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ManagersResponse.fromJson(Map<String, dynamic>? json) {
    return ManagersResponse(
      success: json?['success'],
      message: json?['message'],
      data: json?['data']
          ?.map<ManagerModel>((e) => ManagerModel.fromJson(e))
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
