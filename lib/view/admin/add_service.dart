import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);
  static const routeName = "addService";
  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
