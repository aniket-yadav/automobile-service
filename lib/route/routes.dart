import 'package:automobileservice/change_password.dart';
import 'package:automobileservice/menu/manager_menu_screen.dart';

import 'package:automobileservice/view/admin/admin_main_screen.dart';
import 'package:automobileservice/view/admin/feedbacks.dart';
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
  ManagerMainScreen.routeName: (_) => const ManagerMenuScreen(),
  Login.routeName: (_) => const Login(),
  Feedbacks.routeName: (_) => const Feedbacks(),
  ForgotPassword.routeName: (_) => const ForgotPassword(),
  CustomerRegister.routeName: (_) => const CustomerRegister(),
  ChangePassword.routeName: (_) => const ChangePassword(),
};
