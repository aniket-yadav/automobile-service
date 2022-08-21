import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/enum/roles.dart';
import 'package:automobileservice/model/customer_mode.dart';
import 'package:automobileservice/utils/snackbar.dart';
import 'package:automobileservice/view/admin/add_service_center.dart';
import 'package:automobileservice/view/admin/services.dart';
import 'package:automobileservice/view/center_on_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as excel;
import 'dart:io';
import 'package:intl/intl.dart';

class ServiceCenters extends StatefulWidget {
  const ServiceCenters({Key? key}) : super(key: key);
  static const routeName = "/serviceCenters";

  @override
  State<ServiceCenters> createState() => _ServiceCentersState();
}

class _ServiceCentersState extends State<ServiceCenters> {
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Service centers"),
        actions: [
          if (dataController.centers.isNotEmpty)
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
      floatingActionButton: dataController.user.role == Role.admin.name
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddServiceCenter.routeName);
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dataController.user.role == Role.customer.name)
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: const Text(
                "Select service center",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
                itemCount: dataController.centers.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (dataController.user.role == Role.customer.name) {
                        Navigator.of(context).pushNamed(Services.routeName);
                      } else if (dataController.user.role == Role.admin.name) {
                        Navigator.of(context).pushNamed(
                            AddServiceCenter.routeName,
                            arguments: dataController.centers[index]);
                      }
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 15.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 15.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 0,
                                  child: Text(
                                    dataController.centers[index].name ?? '',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                if (dataController.centers[index].phone !=
                                        null &&
                                    dataController
                                        .centers[index].phone!.isNotEmpty)
                                  InkWell(
                                    child: const Icon(Icons.call),
                                    onTap: () {
                                      launchUrlString(
                                          "tel:+91${dataController.centers[index].phone}");
                                    },
                                  ),
                              ],
                            ),
                            Text(
                              dataController.centers[index].city ?? '',
                              style: const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(Services.routeName);
                                    dataController.order.center =
                                        dataController.centers[index];
                                    if (dataController.user.role ==
                                        Role.customer.name) {
                                      dataController.order.customer =
                                          CustomerModel(
                                        address: dataController.user.address,
                                        city: dataController.user.city,
                                        customerid: dataController.user.userid,
                                        district: dataController.user.district,
                                        email: dataController.user.email,
                                        image: dataController.user.image,
                                        mobile: dataController.user.mobile,
                                        name: dataController.user.name,
                                        pincode: dataController.user.pincode,
                                        role: dataController.user.role,
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Book",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    var lat = dataController
                                            .centers[index].latitude ??
                                        '';
                                    var lng = dataController
                                            .centers[index].longitude ??
                                        '';

                                    if (lat.isNotEmpty && lng.isNotEmpty) {
                                      Navigator.of(context).pushNamed(
                                          CenterOnMap.routeName,
                                          arguments: LatLng(double.parse(lat),
                                              double.parse(lng)));
                                    } else {
                                      snackBar(
                                          "Co-ordinate not available", context);
                                    }
                                  },
                                  icon: const Icon(Icons.map),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
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
    final feedbacks =
        Provider.of<DataController>(context, listen: false).centers;
    final isPermissionStatusGranted = await _requestPermissions();
    final dir = await _getDownloadDirectory();
    if (isPermissionStatusGranted) {
      final excel.Workbook workbook = excel.Workbook();
      final excel.Worksheet sheet = workbook.worksheets[0];

      sheet.getRangeByName("A1").setText("Center Id");
      sheet.getRangeByName("B1").setText("Name");
      sheet.getRangeByName("C1").setText("Manager Id");
      sheet.getRangeByName("D1").setText("Address");
      sheet.getRangeByName("E1").setText("City");
      sheet.getRangeByName("F1").setText("District");
      sheet.getRangeByName("G1").setText("Pincode");
      sheet.getRangeByName("H1").setText("Latitude");
      sheet.getRangeByName("I1").setText("Longitude");
      sheet.getRangeByName("J1").setText("Phone");
      int i = 2;
      for (var element in feedbacks) {
        sheet.getRangeByName("A$i").setText(element.centerid);
        sheet.getRangeByName("B$i").setText(element.name);
        sheet.getRangeByName("C$i").setText(element.managerid);
        sheet.getRangeByName("D$i").setText(element.address);
        sheet.getRangeByName("E$i").setText(element.city);
        sheet.getRangeByName("F$i").setText(element.district);
        sheet.getRangeByName("G$i").setText(element.pincode);
        sheet.getRangeByName("H$i").setText(element.latitude);
        sheet.getRangeByName("I$i").setText(element.longitude);
        sheet.getRangeByName("J$i").setText(element.phone);
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
