import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddManager extends StatefulWidget {
  const AddManager({Key? key}) : super(key: key);
  static const routeName = "/addManager";
  @override
  State<AddManager> createState() => _AddManagerState();
}

class _AddManagerState extends State<AddManager> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Manager"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter name",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z.' ]"),
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter email",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: TextField(
                controller: mobileController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Enter mobile",
                  counterText: '',
                  prefixText: "+91",
                ),
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 30.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  var name = nameController.text.trim();
                  var email = emailController.text.trim();
                  var mobile = mobileController.text.trim();
                  if (name.isNotEmpty &&
                      email.isNotEmpty &&
                      mobile.isNotEmpty) {
                    dataController.addManager(
                      name: name,
                      email: email,
                      mobile: mobile,
                    );
                  } else {
                    snackBar("Please fill all details", context);
                  }
                },
                child: const Text("Register"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
