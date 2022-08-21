import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);
  static const routeName = "addService";
  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  TextEditingController nameController = TextEditingController();
  TextEditingController chargeController = TextEditingController();

  ServiceModel? _serviceModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _serviceModel =
            ModalRoute.of(context)?.settings.arguments as ServiceModel?;

        if (_serviceModel != null) {
          nameController.text = _serviceModel?.name ?? '';
          chargeController.text = _serviceModel?.charge ?? '';
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Service"),
        actions: _serviceModel != null
            ? [
                IconButton(
                  onPressed: () {
                    dataController
                        .deleteService(id: _serviceModel?.serviceid ?? '')
                        .then((value) {
                      Navigator.of(context).pop();
                    });
                  },
                  icon: const Icon(Icons.delete_outline),
                )
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter service",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z.0-9 ]"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: chargeController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter service charge",
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 30.0,
              ),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  var name = nameController.text.trim();
                  var charge = chargeController.text.trim();
                  if (name.isNotEmpty && charge.isNotEmpty) {
                    if (_serviceModel != null) {
                      dataController.updateService(
                          id: _serviceModel?.serviceid ?? '',
                          name: name,
                          charge: charge);
                    } else {
                      dataController.saveService(name: name, charge: charge);
                    }
                  }
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
