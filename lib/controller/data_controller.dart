import 'dart:convert';

import 'package:automobileservice/enum/roles.dart';
import 'package:automobileservice/model/feedback_model.dart';
import 'package:automobileservice/model/feedback_response.dart';
import 'package:automobileservice/model/response_model.dart';
import 'package:automobileservice/model/user_model.dart';
import 'package:automobileservice/service/service_call_get.dart';
import 'package:automobileservice/service/service_call_post.dart';
import 'package:automobileservice/utils/global_variable.dart';
import 'package:automobileservice/utils/session_manager.dart';
import 'package:automobileservice/utils/snackbar.dart';

import 'package:automobileservice/view/admin/admin_main_screen.dart';

import 'package:automobileservice/view/customer/customer_main_screen.dart';

import 'package:automobileservice/view/manager/manager_main_screen.dart';

import 'package:automobileservice/service/services.dart' as services;
import 'package:flutter/material.dart';

class DataController with ChangeNotifier {
  User _user = User();

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  User get user => _user;

  getUser() async {
    user = User.fromJson(jsonDecode(await SessionManager.getUser()));
  }

  void login({required String username, required String password}) async {
    Map<String, dynamic> body = {
      "username": username,
      'password': password,
    };
    print("object");
    var res = await serviceCallPost(body: body, path: services.login);
    print(res.body);
    print(res.statusCode);
    print(body);
    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        var role = jsonDecode(res.body)['role'];
        var userid = jsonDecode(res.body)['userid'];
        SessionManager.saveRole(role);
        fetchProfile(userid: userid, role: role);
        if (role == Role.admin.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(AdminMainScreen.routeName);
        } else if (role == Role.customer.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(CustomerMainScreen.routeName);
        } else if (role == Role.manager.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .pushReplacementNamed(ManagerMainScreen.routeName);
        }
        snackBar(
            response.message ?? '', GlobalVariable.navState.currentContext!);
      }
    }
  }

  void fetchProfile({String? userid, required String role}) async {
    String endPoint = '';
    if (role == Role.admin.name) {
      endPoint = services.getAdmin;
    } else if (role == Role.customer.name) {
      endPoint = services.getCustomer;
    } else if (role == Role.manager.name) {
      endPoint = services.getManager;
    }
    if (endPoint.isEmpty) {
      return;
    }

    Map<String, dynamic> body = {
      "userid": userid ?? user.userid,
    };

    var res = await serviceCallPost(body: body, path: endPoint);
    print(res.body);
    print(res.statusCode);
    if (res.statusCode == 200) {
      print(res.body);
      SessionManager.saveUser(jsonEncode(jsonDecode(res.body)['data']));
      getUser();
    }
  }

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
    var res = await serviceCallPost(
      body: body,
      path: services.addFeedbackService,
    );
    print(res.body);
    print(res.statusCode);
  }

  List<FeedbackModel> _feedBacks = [];

  List<FeedbackModel> get feedBacks => _feedBacks;

  set feedBacks(List<FeedbackModel> value) {
    _feedBacks = value;
    notifyListeners();
  }

  getFeedbacks() async {
    var res = await serviceCallGet(path: services.getFeedbacks);

    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      FeedbackResponse feedbackResponse =
          FeedbackResponse.fromJson(jsonDecode(res.body));
      if (feedbackResponse.success == true) {
        if (feedbackResponse.data != null) {
          feedBacks = feedbackResponse.data ?? [];
        } else {
          feedBacks = [];
        }
      } else {
        feedBacks = [];
      }
    } else {
      feedBacks = [];
    }
  }

  //  reset password
  void resetPassword({required String role, required String email}) async {
    Map<String, dynamic> body = {
      "role": role,
      "email": email,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.resetPassword,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
      if (response.success == true) {
        Navigator.of(GlobalVariable.navState.currentContext!).pop();
      }
    }
  }

  void registerCutomer(
      {required String name,
      required String email,
      required String mobile}) async {
    Map<String, dynamic> body = {
      "name": name,
      "email": email,
      "mobile": mobile,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.regiterCustomerService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  uploadPhoto({String? image, required String role}) async {
    Map<String, dynamic> body = {
      "role": role,
      "image": image ?? '',
      "userid": user.userid,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.uploadProfilePhoto,
    );

    if (res.statusCode == 200) {
      fetchProfile(role: role);
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

//  change password
  changePassword({
    required String role,
    required String oldPassword,
    required String newPassword,
  }) async {
    Map<String, dynamic> body = {
      "role": role,
      "userid": user.userid,
      "oldpassword": oldPassword,
      "newpassword": newPassword,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.changePasswordService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      fetchProfile(role: role);
      Response response = Response.fromJson(jsonDecode(res.body));
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }
}
