import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/enum/roles.dart';
import 'package:automobileservice/utils/snackbar.dart';
import 'package:automobileservice/view/admin/add_service_center.dart';
import 'package:automobileservice/view/admin/services.dart';
import 'package:automobileservice/view/center_on_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ServiceCenters extends StatelessWidget {
  const ServiceCenters({Key? key}) : super(key: key);
  static const routeName = "/serviceCenters";
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Service centers"),
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
                    onTap: dataController.user.role == Role.customer.name
                        ? () {
                            Navigator.of(context).pushNamed(Services.routeName);
                          }
                        : null,
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
}
