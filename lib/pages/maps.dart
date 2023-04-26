import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  const Maps({Key? key}) : super(key: key);

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.669111, 80.014007),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(9.669111, 80.014007),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  LatLng center = LatLng(9.669111, 80.014007);

  final Marker marker = Marker(
    markerId: MarkerId('place_name'),
    position: LatLng(
      LatLng(9.669111, 80.014007).latitude + sin(1 * pi / 6.0) / 20.0,
      LatLng(9.669111, 80.014007).longitude + cos(1 * pi / 6.0) / 20.0,
    ),
    infoWindow: InfoWindow(title: "0", snippet: '*'),
    onTap: () {},
  );

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initState() {
    markers[MarkerId('place_name')] = marker;
  }


  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.terrain,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: Set<Marker>.of(markers.values),
    );
  }
}
