import 'package:automobileservice/controller/data_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Service"),
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
                    dataController.saveService(name:name,charge:charge);
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
