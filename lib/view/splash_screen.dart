import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/enum/roles.dart';
import 'package:automobileservice/utils/global_variable.dart';
import 'package:automobileservice/utils/session_manager.dart';
import 'package:automobileservice/view/admin/admin_main_screen.dart';
import 'package:automobileservice/view/customer/customer_main_screen.dart';
import 'package:automobileservice/view/login.dart';
import 'package:automobileservice/view/manager/manager_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:automobileservice/assets/images.dart' as icons;
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      checkLogin();
    });
    super.initState();
  }

  checkLogin() async {
    bool hasUser = await SessionManager.hasUser();
    String role = await SessionManager.getRole();

    if (hasUser) {
      Provider.of<DataController>(GlobalVariable.navState.currentContext!,
              listen: false)
          .getUser();
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
    } else {
      Navigator.of(GlobalVariable.navState.currentContext!)
          .pushReplacementNamed(Login.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF107189),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage(icons.automobilelogo),
            ),
          ],
        ),
      ),
    );
  }
}
