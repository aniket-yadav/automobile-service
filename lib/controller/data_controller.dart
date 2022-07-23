import 'dart:convert';

import 'package:automobileservice/enum/roles.dart';
import 'package:automobileservice/model/center_model.dart';
import 'package:automobileservice/model/center_response.dart';
import 'package:automobileservice/model/customer_mode.dart';
import 'package:automobileservice/model/customers_response.dart';
import 'package:automobileservice/model/feedback_model.dart';
import 'package:automobileservice/model/feedback_response.dart';
import 'package:automobileservice/model/manager_model.dart';
import 'package:automobileservice/model/managers_response.dart';
import 'package:automobileservice/model/response_model.dart';
import 'package:automobileservice/model/service_model.dart';
import 'package:automobileservice/model/services_response.dart';
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

  void addFeedback({
    required String comment,
    required int rate,
  }) async {
    Map<String, dynamic> body = {
      "comment": comment,
      "author": user.name,
      "date": DateTime.now().toIso8601String().substring(0, 16),
      "rate": rate.toString(),
      "email": user.email,
    };
    var res = await serviceCallPost(
      body: body,
      path: services.addFeedbackService,
    );

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        Navigator.of(GlobalVariable.navState.currentContext!).pop();
      }
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
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

  List<CustomerModel> _customers = [];

  List<CustomerModel> get customers => _customers;

  set customers(List<CustomerModel> value) {
    _customers = value;
    notifyListeners();
  }

  getCustomers() async {
    var res = await serviceCallGet(path: services.customersService);

    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      CustomersResponse customersResponse =
          CustomersResponse.fromJson(jsonDecode(res.body));
      if (customersResponse.success == true) {
        if (customersResponse.data != null) {
          customers = customersResponse.data ?? [];
        } else {
          customers = [];
        }
      } else {
        customers = [];
      }
    } else {
      customers = [];
    }
  }

  void addManager(
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
      path: services.addManagerService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));

      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  void saveService({
    required String name,
    required String charge,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "charge": charge,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.saveChargeService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      getServices();
      Navigator.of(GlobalVariable.navState.currentContext!).pop();
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  List<ServiceModel> _servicesList = [];

  List<ServiceModel> get servicesList => _servicesList;

  set servicesList(List<ServiceModel> value) {
    _servicesList = value;
    notifyListeners();
  }

  getServices() async {
    var res = await serviceCallGet(path: services.servicesList);

    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      ServicesResponse servicesResponse =
          ServicesResponse.fromJson(jsonDecode(res.body));
      if (servicesResponse.success == true) {
        if (servicesResponse.data != null) {
          servicesList = servicesResponse.data ?? [];
        } else {
          servicesList = [];
        }
      } else {
        servicesList = [];
      }
    } else {
      servicesList = [];
    }
  }

  List<ManagerModel> _managers = [];

  List<ManagerModel> get managers => _managers;

  set managers(List<ManagerModel> value) {
    _managers = value;
    notifyListeners();
  }

  void getManagers() async {
    var res = await serviceCallGet(path: services.managersService);

    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      ManagersResponse managersResponse =
          ManagersResponse.fromJson(jsonDecode(res.body));
      if (managersResponse.success == true) {
        if (managersResponse.data != null) {
          managers = managersResponse.data ?? [];
        } else {
          managers = [];
        }
      } else {
        managers = [];
      }
    } else {
      managers = [];
    }
  }

  void saveServiceCenter({
    String? name,
    String? address,
    String? district,
    String? city,
    String? pincode,
    String? lat,
    String? lng,
  }) async {
    Map<String, dynamic> body = {
      "name": name,
      "address": address,
      "district": district,
      "city": city,
      "pincode": pincode,
      "lat": lat,
      "lng": lng,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.saveServiceCenter,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      getServices();
      Navigator.of(GlobalVariable.navState.currentContext!).pop();
      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  List<CenterModel> _centers = [];

  List<CenterModel> get centers => _centers;

  set centers(List<CenterModel> value) {
    _centers = value;
    notifyListeners();
  }

  void getServiceCenters() async {
    var res = await serviceCallGet(path: services.serviceCentersService);

    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      CenterResponse centerResponse =
          CenterResponse.fromJson(jsonDecode(res.body));
      if (centerResponse.success == true) {
        if (centerResponse.data != null) {
          centers = centerResponse.data ?? [];
        } else {
          centers = [];
        }
      } else {
        centers = [];
      }
    } else {
      centers = [];
    }
  }

  void assignCenter(
      {String? managerid,
      String? centerid,
      String? manager,
      String? center}) async {
    print(managerid);
    print(centerid);
    Map<String, dynamic> body = {
      "managerid": managerid,
      "manager": manager,
      "center": center,
      "centerid": centerid,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.assignCenterService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        getManagers();
        getServiceCenters();
      }

      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  updateProfile(
      {String? name,
      String? mobile,
      String? address,
      String? district,
      String? city,
      String? pincode}) async {
    String endPoint = '';
    if (user.role == Role.admin.name) {
      endPoint = services.updateAdminService;
    } else if (user.role == Role.customer.name) {
      endPoint = services.updateCustomerService;
    } else if (user.role == Role.manager.name) {
      endPoint = services.updateManagerService;
    }
    if (endPoint.isEmpty) {
      return;
    }
    Map<String, dynamic> body = {
      "userid": user.userid,
      "name": name,
      "mobile": mobile,
      "address": address,
      "district": district,
      "city": city,
      "pincode": pincode,
    };

    var res = await serviceCallPost(
      body: body,
      path: endPoint,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        fetchProfile(role: user.role ?? '');
        Navigator.of(GlobalVariable.navState.currentContext!).pop();
      }

      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }
}
