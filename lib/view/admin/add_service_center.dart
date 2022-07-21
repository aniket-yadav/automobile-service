import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/utils/global_variable.dart';
import 'package:automobileservice/view/admin/center_selection_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class AddServiceCenter extends StatefulWidget {
  const AddServiceCenter({Key? key}) : super(key: key);
  static const routeName = "addServiceCenter";
  @override
  State<AddServiceCenter> createState() => _AddServiceCenterState();
}

class _AddServiceCenterState extends State<AddServiceCenter> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  LatLng? mapLocation;
  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Service center"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
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
                hintText: "Center name",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: TextField(
              controller: addressController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter address",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: TextField(
              controller: districtController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "District",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: TextField(
              controller: cityController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter City",
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              maxLength: 6,
              controller: pincodeController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter pincode",
                counterText: '',
              ),
            ),
          ),
          if (mapLocation == null)
            InkWell(
              onTap: () async {
                var hasPermission = await Location.instance.hasPermission();
                if (hasPermission == PermissionStatus.granted) {
                  var latlng = await Navigator.of(
                          GlobalVariable.navState.currentContext!)
                      .pushNamed(CenterSelectionMap.routeName);
                  if (latlng != null) {
                    setState(() {
                      mapLocation = latlng as LatLng;
                      print(latlng.latitude);
                      print(latlng.longitude);
                    });
                  }
                } else {
                  await Location.instance.requestPermission();
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF107189),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20.0,
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Location on Map",
                  style: TextStyle(
                    color: Color(0xFF107189),
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          if (mapLocation != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: Text(
                "Location:\n lat: ${mapLocation?.latitude},\n lng: ${mapLocation?.longitude}",
                style: const TextStyle(
                  color: Color(0xFF107189),
                  fontSize: 12.0,
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                var name = nameController.text.trim();
                var address = addressController.text.trim();
                var district = districtController.text.trim();
                var city = cityController.text.trim();
                var pincode = pincodeController.text.trim();
                if (name.isNotEmpty) {
                  dataController.saveServiceCenter(
                    name: name,
                    address: address,
                    district: district,
                    city: city,
                    pincode: pincode,
                    lat: "${mapLocation?.latitude}",
                    lng: "${mapLocation?.longitude}",
                  );
                }
              },
              child: const Text("Submit"),
            ),
          )
        ],
      )),
    );
  }
}
