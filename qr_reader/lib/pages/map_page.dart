//    final ScanModel scan =
//        ModalRoute.of(context)!.settings.arguments as ScanModel;
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/models/scan_model.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition initialPoint =
        CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 50);

    // Marker
    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
        markerId: const MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
              icon: const Icon(Icons.location_on,
                  color: Color.fromRGBO(234, 67, 53, 1)),
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: scan.getLatLng(), zoom: 17.5, tilt: 50)));
              })
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.layers),
          onPressed: () {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else if (mapType == MapType.satellite) {
              mapType = MapType.hybrid;
            } else if (mapType == MapType.hybrid) {
              mapType = MapType.terrain;
            } else {
              mapType = MapType.normal;
            }

            setState(() {});
          }),
    );
  }
}
