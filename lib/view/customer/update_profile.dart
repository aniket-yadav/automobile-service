import 'package:automobileservice/controller/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);
  static const routeName = "/updatePtofile";
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      setState(() {
        nameController.text = dataController.user.name ?? '';
        mobileController.text = dataController.user.mobile ?? '';
        addressController.text = dataController.user.address ?? '';
        districtController.text = dataController.user.district ?? '';
        cityController.text = dataController.user.city ?? '';
        pincodeController.text = dataController.user.pincode ?? '';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Name",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp("[a-zA-Z. ]"),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Mobile",
                  counterText: '',
                ),
                maxLength: 10,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Address",
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
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: districtController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "District",
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
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "City",
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
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: TextField(
                controller: pincodeController,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "Pincode",
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  var name = nameController.text.trim();
                  var mobile = mobileController.text.trim();
                  var address = addressController.text.trim();
                  var district = districtController.text.trim();
                  var city = cityController.text.trim();
                  var pincode = pincodeController.text.trim();

                  dataController.updateProfile(
                    address: address,
                    city: city,
                    district: district,
                    mobile: mobile,
                    name: name,
                    pincode: pincode,
                  );
                },
                child: const Text("Update"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
