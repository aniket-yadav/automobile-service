import 'package:automobileservice/view/admin/add_service_center.dart';
import 'package:flutter/material.dart';

class ServiceCenters extends StatelessWidget {
  const ServiceCenters({Key? key}) : super(key: key);
  static const routeName = "/serviceCenters";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service centers"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddServiceCenter.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
