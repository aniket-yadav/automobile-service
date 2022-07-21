import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/view/admin/add_manager.dart';
import 'package:automobileservice/widgets/option_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Managers extends StatefulWidget {
  const Managers({Key? key}) : super(key: key);
  static const routeName = "/managers";
  @override
  State<Managers> createState() => _ManagersState();
}

class _ManagersState extends State<Managers> {
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Managers"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddManager.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: dataController.managers.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                var res = await showOptionModal(
                    context,
                    dataController.managers[index].managerid,
                    dataController.centers.map((e) => e.name).toList());
                if (res != null) {
                  dataController.assignCenter(
                    centerid: dataController.centers
                            .firstWhere((element) => element.name == res)
                            .centerid ??
                        '',
                    managerid: dataController.managers[index].managerid ?? '',
                    center: dataController.centers
                            .firstWhere((element) => element.name == res)
                            .name ??
                        '',
                    manager: dataController.managers[index].name ?? '',
                  );
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
                                  dataController.managers[index].name ?? '',
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  dataController.managers[index].mobile ?? '',
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
