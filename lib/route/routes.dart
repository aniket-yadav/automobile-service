import 'package:automobileservice/view/admin/admin_dashboard.dart';
import 'package:automobileservice/view/splash_screen.dart';
import 'package:flutter/widgets.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  AdminDashboard.routeName: (_) => const AdminDashboard(),
};
