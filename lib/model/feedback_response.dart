import 'package:automobileservice/model/feedback_model.dart';

class FeedbackResponse {
  bool? success;
  String? message;
  List<FeedbackModel>? data;

  FeedbackResponse({
    this.success,
    this.message,
    this.data,
  });

   factory FeedbackResponse.fromJson(Map<String, dynamic>? json) {
    return FeedbackResponse(
      success: json?['success'],
       message: json?['message'],
       data: json?['data']?.map<FeedbackModel>((e)=> FeedbackModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> temp = {
      'success':success,
      'message':message,
      'data':data?.map((e) => e.toJson()).toList(),
    };
    temp.removeWhere((key, value) => value == null);

    return temp;
  }
}
