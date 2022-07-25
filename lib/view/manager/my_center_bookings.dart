import 'dart:convert';

import 'package:automobileservice/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'dart:io';
import 'package:intl/intl.dart';

class MyCenterBookings extends StatefulWidget {
  const MyCenterBookings({Key? key}) : super(key: key);
  static const routeName = "/myCenterBookings";
  @override
  State<MyCenterBookings> createState() => _MyCenterBookingsState();
}

class _MyCenterBookingsState extends State<MyCenterBookings> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.allBookings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        actions: [
          if (dataController.myBookings.isNotEmpty)
            IconButton(
              onPressed: () {
                createExcel();
              },
              icon: const Icon(
                Icons.download,
                color: Colors.white,
              ),
            ),
        ],
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
                ],
              ),
            );
          }),
    );
  }

  Future<Directory?> _getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return Directory('/storage/emulated/0/Download');
    }
    // iOS directory visible to user
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions() async {
    var permissionStorage = await Permission.storage.status.isGranted;
    if (permissionStorage) {
      return true;
    }
    var status = await Permission.storage.request();
    return status == PermissionStatus.granted;
  }

  Future<void> createExcel() async {
    final orders =
        Provider.of<DataController>(context, listen: false).myBookings;
    final isPermissionStatusGranted = await _requestPermissions();
    final dir = await _getDownloadDirectory();
    if (isPermissionStatusGranted) {
      final excel.Workbook workbook = excel.Workbook();
      final excel.Worksheet sheet = workbook.worksheets[0];

      sheet.getRangeByName("A1").setText("Report Id");
      sheet.getRangeByName("B1").setText("Customer Id");
      sheet.getRangeByName("C1").setText("Customer Json");
      sheet.getRangeByName("D1").setText("Service Center Id");
      sheet.getRangeByName("E1").setText("Service Center Json");
      sheet.getRangeByName("F1").setText("Services");
      sheet.getRangeByName("G1").setText("Payable");
      sheet.getRangeByName("H1").setText("Payment Status");
      sheet.getRangeByName("I1").setText("Payment Id");
      sheet.getRangeByName("J1").setText("status");
      int i = 2;
      for (var element in orders) {
        sheet.getRangeByName("A$i").setText(element.reportid);
        sheet.getRangeByName("B$i").setText(element.customerid);
        sheet
            .getRangeByName("C$i")
            .setText(jsonEncode(element.customer?.toJson()));
        sheet.getRangeByName("D$i").setText(element.servicecenterid);
        sheet
            .getRangeByName("E$i")
            .setText(jsonEncode(element.center?.toJson()));
        sheet.getRangeByName("F$i").setText(
            jsonEncode(element.services?.map((e) => e.toJson()).toList()));
        sheet.getRangeByName("G$i").setText(element.payable);
        sheet.getRangeByName("H$i").setText(element.paymentstatus);
        sheet.getRangeByName("I$i").setText(element.paymentid);
        sheet.getRangeByName("J$i").setText(element.status);
        i += 1;
      }

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      // final String path = (await getApplicationSupportDirectory()).path;
      final String path = dir?.path ?? "/storage/emulated/0/Download";
      final String fileName =
          "$path/${DateFormat("ddMMyyyyhhmm").format(DateTime.now())}.xlsx";
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
    }
  }
}
