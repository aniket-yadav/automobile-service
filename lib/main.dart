import 'package:automobileservice/assets/custom_theme.dart';
import 'package:automobileservice/route/routes.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const AutoMobileService());
}

class AutoMobileService extends StatelessWidget {
  const AutoMobileService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: customTheme,
    );
  }
}
