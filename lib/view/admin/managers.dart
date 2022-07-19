import 'package:automobileservice/view/admin/add_manager.dart';
import 'package:flutter/material.dart';

class Managers extends StatefulWidget {
  const Managers({Key? key}) : super(key: key);
  static const routeName = "/managers";
  @override
  State<Managers> createState() => _ManagersState();
}

class _ManagersState extends State<Managers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Managers"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddManager.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
