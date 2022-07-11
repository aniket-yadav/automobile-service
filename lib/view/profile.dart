import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final VoidCallback openDrawer;
  const Profile({Key? key, required this.openDrawer}) : super(key: key);
  static const routeName = "/profile";
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          widget.openDrawer();
        },
      )),
    );
  }
}
