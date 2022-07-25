import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/enum/roles.dart';
import 'package:automobileservice/view/customer/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPreview extends StatefulWidget {
  const OrderPreview({Key? key}) : super(key: key);
  static const routeName = "/orderPreview";
  @override
  State<OrderPreview> createState() => _OrderPreviewState();
}

class _OrderPreviewState extends State<OrderPreview> {
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Preview"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    Text(dataController.order.center?.name ?? ''),
                    const Spacer(),
                    const Icon(
                      Icons.location_on,
                      color: Color(0xFF107189),
                    ),
                    Text(dataController.order.center?.city ?? ''),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Services:"),
                      ...?dataController.order.services?.map((e) {
                        return Row(
                          children: [
                            Flexible(
                              flex: 0,
                              child: Text(
                                e.name ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "₹ ${e.charge}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Row(children: [
                  const Text(
                    "Total Payable",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "₹ ${dataController.order.services?.fold(0, (previousValue, element) => (previousValue as int) + num.parse(element.charge!))}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  "*payment after service delivery",
                  style: TextStyle(
                    fontSize: 13.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Pick up address"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_city,
                          color: Color(0xFF107189),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (dataController.order.customer?.address != null &&
                            dataController.order.customer?.city != null &&
                            dataController.order.customer?.district != null &&
                            dataController.order.customer?.pincode != null)
                          Flexible(
                            child: Text(
                              " ${dataController.order.customer?.address ?? ''}, ${dataController.order.customer?.city ?? ''}, ${dataController.order.customer?.district ?? ''}, ${dataController.order.customer?.pincode ?? ''}",
                            ),
                          ),
                        if (dataController.order.customer?.address == null &&
                            dataController.order.customer?.city == null &&
                            dataController.order.customer?.district == null &&
                            dataController.order.customer?.pincode == null)
                          InkWell(
                            onTap:
                                dataController.user.role == Role.customer.name
                                    ? () {
                                        Navigator.of(context)
                                            .pushNamed(UpdateProfile.routeName);
                                      }
                                    : null,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text("Add address"),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: ElevatedButton(
                  onPressed: () {
                    dataController.book();
                  },
                  child: const Text("Confirm"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
