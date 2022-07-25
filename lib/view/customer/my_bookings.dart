
import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/enum/booking.dart';
import 'package:automobileservice/enum/payment.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';


class MyBookings extends StatefulWidget {
  const MyBookings({Key? key}) : super(key: key);
  static const routeName = "/myBookings";
  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.getMyBooking();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
      ),
      body: ListView.builder(
          itemCount: dataController.myBookings.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
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
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        dataController.myBookings[index].center?.name ?? '',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF107189),
                      ),
                      Text(
                        dataController.myBookings[index].center?.city ?? '',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text("Services:"),
                  ...?dataController.myBookings[index].services?.map((e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Text(
                          "₹ ${e.charge}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Payable",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹ ${dataController.myBookings[index].payable}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xFF666666),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Payment status",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "₹ ${dataController.myBookings[index].paymentstatus}",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "₹ ${dataController.myBookings[index].status}",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (dataController.myBookings[index].status ==
                          BookingStatus.complete.name &&
                      dataController.myBookings[index].paymentstatus ==
                          PaymentStatus.unpaid.name)
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          dataController.makePayment(
                              amount:
                                  dataController.myBookings[index].payable ??
                                      '',
                              orderid:
                                  dataController.myBookings[index].reportid ??
                                      '');
                        },
                        child: const Text("Pay"),
                      ),
                    )
                ],
              ),
            );
          }),
    );
  }

}
