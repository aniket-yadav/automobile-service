import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/enum/roles.dart';
import 'package:automobileservice/model/service_model.dart';
import 'package:automobileservice/view/admin/add_service.dart';
import 'package:automobileservice/view/customer/order_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Services extends StatefulWidget {
  const Services({Key? key}) : super(key: key);
  static const routeName = "/services";
  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final List<ServiceModel> _selectedService = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.getServices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text("services"),
      ),
      floatingActionButton: dataController.user.role != Role.customer.name
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddService.routeName);
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: _selectedService.isNotEmpty
          ? Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: ElevatedButton(
                child: const Text("Continue"),
                onPressed: () {
                  Navigator.of(context).pushNamed(OrderPreview.routeName);
                  dataController.order.services = _selectedService;
                },
              ),
            )
          : null,
      body: ListView.builder(
          itemCount: dataController.servicesList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (dataController.user.role != Role.admin.name) {
                  setState(() {
                    if (_selectedService
                        .contains(dataController.servicesList[index])) {
                      _selectedService
                          .remove(dataController.servicesList[index]);
                    } else {
                      _selectedService.add(dataController.servicesList[index]);
                    }
                  });
                } else if (dataController.user.role == Role.admin.name) {
                  Navigator.of(context).pushNamed(AddService.routeName,
                      arguments: dataController.servicesList[index]);
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                  border: _selectedService
                          .contains(dataController.servicesList[index])
                      ? Border.all(
                          color: const Color(0xFF107189),
                        )
                      : null,
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
              ),
            );
          }),
    );
  }
}
