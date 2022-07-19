import 'package:flutter/material.dart';

class AddServiceCenter extends StatefulWidget {
  const AddServiceCenter({Key? key}) : super(key: key);
  static const routeName = "addServiceCenter";
  @override
  State<AddServiceCenter> createState() => _AddServiceCenterState();
}

class _AddServiceCenterState extends State<AddServiceCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Service center"),
      ),
    );
  }
}
