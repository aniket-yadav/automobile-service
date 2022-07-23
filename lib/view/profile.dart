import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/view/customer/update_profile.dart';
import 'package:automobileservice/widgets/profile_photo_selection_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:automobileservice/assets/images.dart' as icons;

class Profile extends StatefulWidget {
  final VoidCallback openDrawer;
  const Profile({Key? key, required this.openDrawer}) : super(key: key);
  static const routeName = "/profile";
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final dataController =
          Provider.of<DataController>(context, listen: false);
      dataController.fetchProfile(role: dataController.user.role ?? '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<DataController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            widget.openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(UpdateProfile.routeName);
            },
            icon: const Icon(
              Icons.edit,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 50.0,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFcfe3e7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 42.0,
                                child: (userProvider.user.image != null &&
                                        userProvider.user.image!.isNotEmpty)
                                    ? Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                          child: Image.network(
                                            userProvider.user.image!,
                                            height: 80.0,
                                            width: 80.0,
                                          ),
                                        ),
                                      )
                                    : Image.asset(
                                        icons.profilePlaceholder,
                                      ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () async {
                                  var res = await showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => Container(
                                      color: Colors.transparent,
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      child: ProfilePhotoSelectionPanel(),
                                    ),
                                  );
                                  if (res == true) {
                                    userProvider.fetchProfile(
                                        role: userProvider.user.role ?? '');
                                  }
                                },
                                icon: const Icon(
                                  Icons.photo_camera,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          userProvider.user.name ?? '',
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff191919),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userProvider.user.email ?? '',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff797979),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userProvider.user.mobile ?? '',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff797979),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 30.0,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_city,
                    color: Color(0xFF107189),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  if (userProvider.user.address != null &&
                      userProvider.user.city != null &&
                      userProvider.user.district != null &&
                      userProvider.user.pincode != null)
                    Flexible(
                        child: Text(
                            " ${userProvider.user.address ?? ''}, ${userProvider.user.city ?? ''}, ${userProvider.user.district ?? ''}, ${userProvider.user.pincode ?? ''}")),
                  if (userProvider.user.address == null &&
                      userProvider.user.city == null &&
                      userProvider.user.district == null &&
                      userProvider.user.pincode == null)
                    const Flexible(child: Text("N/A"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
