import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/view/admin/add_service_center.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddServiceCenter.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: dataController.centers.length,
          itemBuilder: (context, index) {
            return Card(
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
                                dataController.centers[index].name ?? '',
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                dataController.centers[index].city ?? '',
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
            );
          }),
    );
  }
}
