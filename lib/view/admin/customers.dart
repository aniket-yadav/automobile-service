import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/enum/roles.dart';
import 'package:automobileservice/view/admin/edit_customer.dart';
import 'package:automobileservice/view/admin/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Customers extends StatefulWidget {
  const Customers({Key? key}) : super(key: key);
  static const routeName = "/customers";
  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customers"),
      ),
      body: ListView.builder(
          itemCount: dataController.customers.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (dataController.user.role == Role.manager.name) {
                  dataController.order.customer =
                      dataController.customers[index];

                  dataController.order.center = dataController.myCenter;
                  Navigator.of(context).pushNamed(Services.routeName);
                }
                if (dataController.user.role == Role.admin.name) {
                  Navigator.of(context).pushNamed(EditCustomer.routeName,
                      arguments: dataController.customers[index]);
                }
              },
              child: Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 15.0,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth * 0.3,
                            child: const Icon(
                              Icons.account_circle,
                              size: 70,
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataController.customers[index].name ?? '',
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  dataController.customers[index].mobile ?? '',
                                  style: const TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}
