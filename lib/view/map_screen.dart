import 'package:automobileservice/controller/data_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const routeName = "/mapScreen";
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  GoogleMapController? controller;
  Set<Marker> markers = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      markCenters();
    });
    super.initState();
  }

  void markCenters() {
    final dataController = Provider.of<DataController>(context, listen: false);
    for (var element in dataController.centers) {
      var lat = element.latitude ?? '';
      var lng = element.longitude ?? '';
      if (lat.isNotEmpty && lng.isNotEmpty) {
        var latlng = LatLng(double.parse(lat), double.parse(lng));
        var marker = Marker(
          markerId: MarkerId(element.centerid!),
          position: latlng,
          infoWindow: InfoWindow(
            title: element.name,
          ),
        );
        setState(() {
          markers.add(marker);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(18.5, 73.8),
          zoom: 8,
        ),
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  @override
  void dispose() {
    if (_controller.isCompleted) {
      disposeController();
    }
    super.dispose();
  }

  disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }
}
