import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/widgets/main_template.dart';

class MapPage extends StatefulWidget {
  static const String routeName = 'mapPage';
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    var index = ModalRoute.of(context).settings.arguments;
    return MainTemplate(
      isHome: false,
      userType: UserType.patient,
      title: Constants.treatmentCenters[index]['hospital'],
      child: (Constants.treatmentCenters[index]['latlng'] == null)
          ? Center(child: const Text('لا يوجد موقع'))
          : GoogleMap(
              zoomGesturesEnabled: true,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: Constants.treatmentCenters[index]['latlng'],
                zoom: 18.0,
              ),
              mapType: MapType.normal,
              markers: {
                Marker(
                  markerId: MarkerId('treatmentCenter $index'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                  position: Constants.treatmentCenters[index]['latlng'],
                  infoWindow: InfoWindow(
                    title: Constants.treatmentCenters[index]['hospital'],
                    snippet: Constants.treatmentCenters[index]['name'],
                  ),
                ),
              },
            ),
    );
  }
}
