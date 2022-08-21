import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/model/center_model.dart';
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

  CenterModel? _centerModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _centerModel =
            ModalRoute.of(context)?.settings.arguments as CenterModel?;
        if (_centerModel != null) {
          nameController.text = _centerModel?.name ?? '';
          addressController.text = _centerModel?.address ?? '';
          districtController.text = _centerModel?.district ?? '';
          cityController.text = _centerModel?.city ?? '';
          pincodeController.text = _centerModel?.pincode ?? '';

          if (_centerModel?.latitude != null &&
              _centerModel?.longitude != null) {
            try {
              setState(() {
                mapLocation = LatLng(
                    double.parse(_centerModel?.latitude != null &&
                            _centerModel!.latitude!.isNotEmpty
                        ? _centerModel!.latitude!
                        : '19.0'),
                    double.parse(_centerModel?.longitude != null &&
                            _centerModel!.longitude!.isNotEmpty
                        ? _centerModel!.longitude!
                        : '72.0'));
              });
            } catch (_) {}
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Service center"),
        actions: _centerModel != null
            ? [
                IconButton(
                    onPressed: () {
                      dataController
                          .deleteCenter(id: _centerModel?.centerid ?? '')
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    icon: const Icon(Icons.delete_outline))
              ]
            : null,
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z. ]"),
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
              controller: addressController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter address",
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z0-9. ]"),
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
              controller: districtController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "District",
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
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: TextField(
              controller: cityController,
              decoration: const InputDecoration(
                filled: true,
                hintText: "Enter City",
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
          // if (mapLocation == null)
          InkWell(
            onTap: () async {
              var hasPermission = await Location.instance.hasPermission();
              if (hasPermission == PermissionStatus.granted) {
                var latlng =
                    await Navigator.of(GlobalVariable.navState.currentContext!)
                        .pushNamed(CenterSelectionMap.routeName,
                            arguments: mapLocation);
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
              child: Text(
                mapLocation != null ? "Change Location" : "Location on Map",
                style: const TextStyle(
                  color: Color(0xFF107189),
                  fontSize: 16.0,
                ),
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
                  if (_centerModel != null) {
                    dataController.updateServiceCenter(
                      id:_centerModel?.centerid ?? '',
                      name: name,
                      address: address,
                      district: district,
                      city: city,
                      pincode: pincode,
                      lat: "${mapLocation?.latitude}",
                      lng: "${mapLocation?.longitude}",
                    );
                  } else {
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
