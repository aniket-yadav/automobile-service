import 'package:automobileservice/service/add_feedback_service.dart';
import 'package:flutter/foundation.dart';

class DataController with ChangeNotifier {
  void addFeedback(
      {required String comment,
      required int rate,
      required String email}) async {
    Map<String, dynamic> body = {
      "comment": comment,
      "author": "Test",
      "date": DateTime.now().toIso8601String().substring(0, 16),
      "rate": rate.toString(),
      "email": email,
    };

    print("ds");
    var res = await addFeedbackService(body);

    print(res.body);
    print(res.statusCode);
  }
}
