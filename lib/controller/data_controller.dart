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
import 'package:automobileservice/model/my_center_response.dart';
import 'package:automobileservice/model/order_model.dart';
import 'package:automobileservice/model/orders_response.dart';
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
import 'package:cashfree_pg/cashfree_pg.dart';
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
  void resetPassword({required String email}) async {
    Map<String, dynamic> body = {
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

  OrderModel _order = OrderModel();

  OrderModel get order => _order;

  set order(OrderModel value) {
    _order = value;
    notifyListeners();
  }

  void book() async {
    Map<String, dynamic> body = {
      "centerid": order.center?.centerid,
      "customerid": order.customer?.customerid,
      "customer": jsonEncode(order.customer?.toJson()),
      "center": jsonEncode(order.center?.toJson()),
      "services": jsonEncode(order.services?.map((e) => e.toJson()).toList()),
      "payable": order.services
          ?.fold(
              0,
              (previousValue, element) =>
                  (previousValue as int) + num.parse(element.charge!))
          .toString(),
    };

    var res = await serviceCallPost(
      body: body,
      path: services.bookingService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        if (user.role == Role.admin.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .popUntil(ModalRoute.withName(AdminMainScreen.routeName));
        } else if (user.role == Role.customer.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .popUntil(ModalRoute.withName(CustomerMainScreen.routeName));
        } else if (user.role == Role.manager.name) {
          Navigator.of(GlobalVariable.navState.currentContext!)
              .popUntil(ModalRoute.withName(ManagerMainScreen.routeName));
        }
      }

      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  List<OrderModel> _myBookings = [];

  List<OrderModel> get myBookings => _myBookings;

  set myBookings(List<OrderModel> value) {
    _myBookings = value;
    notifyListeners();
  }

  void getMyBooking() async {
    Map<String, dynamic> body = {
      "userid": user.userid,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.myBookingService,
    );

    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      OrdersResponse ordersResponse =
          OrdersResponse.fromJson(jsonDecode(res.body));
      if (ordersResponse.success == true) {
        if (ordersResponse.data != null) {
          myBookings = ordersResponse.data ?? [];
        } else {
          myBookings = [];
        }
      } else {
        myBookings = [];
      }
    } else {
      myBookings = [];
    }
  }

  void getMyCenterBooking() async {
    Map<String, dynamic> body = {
      "centerid": user.servicecenterid,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.myCenterBookings,
    );

    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      OrdersResponse ordersResponse =
          OrdersResponse.fromJson(jsonDecode(res.body));
      if (ordersResponse.success == true) {
        if (ordersResponse.data != null) {
          myBookings = ordersResponse.data ?? [];
        } else {
          myBookings = [];
        }
      } else {
        myBookings = [];
      }
    } else {
      myBookings = [];
    }
  }

  void makePayment({required String amount, required String orderid}) async {
    Map<String, dynamic> body = {
      "amount": amount,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.getAccessTokenService,
    );

    print(res.statusCode);
    print(res.body);
    var jsonResponse = jsonDecode(res.body);
    if (jsonResponse['success'] == true) {
      Map<String, String> params = {
        'stage': jsonResponse['mode'],
        'orderAmount': amount,
        'orderId': jsonResponse['orderid'],
        'orderCurrency': 'INR',
        'customerName': user.name ?? '',
        'customerPhone': user.mobile ?? '',
        'customerEmail': user.email ?? '',
        'tokenData': jsonResponse['cftoken'],
        'appId': jsonResponse['id'],
      };
      CashfreePGSDK.doPayment(params).then((value) {
        if (value != null) {
          if (value['txStatus'] == 'SUCCESS') {
            verifySignature(orderid: orderid, value: value);
          } else {
            ScaffoldMessenger.of(GlobalVariable.navState.currentContext!)
                .showSnackBar(
              const SnackBar(
                content: Text("Payment Failed"),
              ),
            );
          }
        }
      });
    } else {
      snackBar(
          jsonResponse['message'], GlobalVariable.navState.currentContext!);
    }
  }

  verifySignature(
      {required Map<dynamic, dynamic> value, required String orderid}) async {
    value['bookingid'] = orderid;
    var res = await serviceCallPost(
      body: value.cast<String, dynamic>(),
      path: services.verifySignatureService,
    );

    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      Response response = Response.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        getMyBooking();
      }

      snackBar(response.message ?? '', GlobalVariable.navState.currentContext!);
    }
  }

  CenterModel? _myCenter;

  CenterModel? get myCenter => _myCenter;

  set myCenter(CenterModel? value) {
    _myCenter = value;
    notifyListeners();
  }

  void myServiceCenter() async {
    Map<String, dynamic> body = {
      "centerid": user.servicecenterid,
    };

    var res = await serviceCallPost(
      body: body,
      path: services.myCenterService,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      MyCenterResponse response =
          MyCenterResponse.fromJson(jsonDecode(res.body));
      if (response.success == true) {
        myCenter = response.data;
      } else {
        snackBar(
            response.message ?? '', GlobalVariable.navState.currentContext!);
      }
    }
  }

  reset() {
    user = User();
    feedBacks = [];
    customers = [];
    servicesList = [];
    managers = [];
    centers = [];
    order = OrderModel();
    myBookings = [];
    myCenter = null;
  }
}
