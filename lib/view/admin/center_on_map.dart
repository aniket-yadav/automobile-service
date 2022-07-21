import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class CenterOnMap extends StatefulWidget {
  const CenterOnMap({Key? key}) : super(key: key);
  static const routeName = "/centerOnMap";
  @override
  State<CenterOnMap> createState() => _CenterOnMapState();
}

class _CenterOnMapState extends State<CenterOnMap> {
  LatLng? centerLoc;
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      centerLoc = ModalRoute.of(context)?.settings.arguments as LatLng?;
    });

    super.initState();
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
        markers: {
          Marker(
            markerId: const MarkerId("center"),
            position: centerLoc ?? const LatLng(19.3, 72.8),
          ),
        },
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: centerLoc ?? const LatLng(19.3, 72.8),
          zoom: 14,
        ),
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
