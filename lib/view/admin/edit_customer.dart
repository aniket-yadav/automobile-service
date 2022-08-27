import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/model/customer_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditCustomer extends StatefulWidget {
  const EditCustomer({Key? key}) : super(key: key);
  static const routeName = "/editCustomer";
  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  CustomerModel? _customerModel;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _customerModel =
          ModalRoute.of(context)?.settings.arguments as CustomerModel?;
      if (_customerModel != null) {
        setState(() {
          nameController.text = _customerModel?.name ?? '';
          mobileController.text = _customerModel?.mobile ?? '';
          addressController.text = _customerModel?.address ?? '';
          districtController.text = _customerModel?.district ?? '';
          cityController.text = _customerModel?.city ?? '';
          pincodeController.text = _customerModel?.pincode ?? '';
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataController = Provider.of<DataController>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Customer"),
          actions: [
            IconButton(
              onPressed: () {
                if (_customerModel != null) {
                  dataController
                      .deleteCustomer(id: _customerModel?.customerid ?? '')
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                }
              },
              icon: const Icon(Icons.delete_outline),
            )
          ],
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

                    dataController.editCustomer(
                      id: _customerModel?.customerid ?? '',
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
      ),
    );
  }
}
