import 'package:flutter/material.dart';

class AddManager extends StatefulWidget {
  const AddManager({Key? key}) : super(key: key);
  static const routeName = "/addManager";
  @override
  State<AddManager> createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Manager"),
      ),
    );
  }
}
