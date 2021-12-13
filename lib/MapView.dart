import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  @override
  _MapView createState() => _MapView();
}

class _MapView extends State<MapView>{
  GoogleMapController? _controller;
  Location currentLocation = Location();
  // Brno loc
  LatLng _initialcameraposition = LatLng(49.195061, 16.606836);
  //TODO: create fnc to add pub markers
  Set<Marker> _markers = {};

  /*
  @override
  void initState(){
    super.initState();
    setState(() {
    //  getLocation();
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack (
          children: [
            GoogleMap(
              zoomControlsEnabled: true,
              initialCameraPosition:CameraPosition(
                target: _initialcameraposition,
                zoom: 12.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                },
              markers: _markers,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ) ,
          ],
        ),
      ),
    );
  }
}