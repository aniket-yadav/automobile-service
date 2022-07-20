import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/view/admin/add_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);
  static const routeName = "/services";
  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("services"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddService.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: dataController.servicesList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1100000D),
                    blurRadius: 16,
                    spreadRadius: 0,
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      dataController.servicesList[index].name ?? '',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Text(
                    "₹ ${dataController.servicesList[index].charge ?? ''}",
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
