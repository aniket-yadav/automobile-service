import 'package:automobileservice/change_password.dart';
import 'package:automobileservice/menu/manager_menu_screen.dart';
import 'package:automobileservice/view/add_feedback.dart';
import 'package:automobileservice/view/admin/add_manager.dart';
import 'package:automobileservice/view/admin/add_service.dart';
import 'package:automobileservice/view/admin/add_service_center.dart';

import 'package:automobileservice/view/admin/admin_main_screen.dart';
import 'package:automobileservice/view/center_on_map.dart';
import 'package:automobileservice/view/admin/center_selection_map.dart';
import 'package:automobileservice/view/admin/customers.dart';
import 'package:automobileservice/view/admin/feedbacks.dart';
import 'package:automobileservice/view/admin/managers.dart';
import 'package:automobileservice/view/customer/my_bookings.dart';
import 'package:automobileservice/view/customer/order_preview.dart';
import 'package:automobileservice/view/customer/update_profile.dart';
import 'package:automobileservice/view/manager/my_center_bookings.dart';
import 'package:automobileservice/view/map_screen.dart';
import 'package:automobileservice/view/service_centers.dart';
import 'package:automobileservice/view/admin/services.dart';
import 'package:automobileservice/view/customer/customer_main_screen.dart';
import 'package:automobileservice/view/customer/customer_register.dart';
import 'package:automobileservice/view/forgot_password.dart';
import 'package:automobileservice/view/login.dart';
import 'package:automobileservice/view/manager/manager_main_screen.dart';
import 'package:automobileservice/view/splash_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  AdminMainScreen.routeName: (_) => const AdminMainScreen(),
  CustomerMainScreen.routeName: (_) => const CustomerMainScreen(),
  ManagerMainScreen.routeName: (_) => const ManagerMainScreen(),
  Login.routeName: (_) => const Login(),
  Feedbacks.routeName: (_) => const Feedbacks(),
  ForgotPassword.routeName: (_) => const ForgotPassword(),
  CustomerRegister.routeName: (_) => const CustomerRegister(),
  ChangePassword.routeName: (_) => const ChangePassword(),
  MapScreen.routeName: (_) => const MapScreen(),
  ServiceCenters.routeName: (_) => const ServiceCenters(),
  Services.routeName: (_) => const Services(),
  Managers.routeName: (_) => const Managers(),
  Customers.routeName: (_) => const Customers(),
  AddServiceCenter.routeName: (_) => const AddServiceCenter(),
  AddManager.routeName: (_) => const AddManager(),
  AddService.routeName: (_) => const AddService(),
  CenterSelectionMap.routeName: (_) => const CenterSelectionMap(),
  CenterOnMap.routeName: (_) => const CenterOnMap(),
  AddFeedback.routeName: (_) => const AddFeedback(),
  UpdateProfile.routeName: (_) => const UpdateProfile(),
  OrderPreview.routeName: (_) => const OrderPreview(),
  MyBookings.routeName: (_) => const MyBookings(),
  MyCenterBookings.routeName: (_) => const MyCenterBookings(),
};
