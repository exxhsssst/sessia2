import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapPage extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late LocationData _currentLocation;
  late LocationData _destinationLocation;

  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  PolylinePoints _polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    var location = Location();
    try {
      _currentLocation = await location.getLocation();
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId("current"),
            position:
                LatLng(_currentLocation.latitude!, _currentLocation.longitude!),
            infoWindow: InfoWindow(title: "Место"),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void _setDestination(LatLng destination) {
    setState(() {
      _destinationLocation = LocationData.fromMap({
        "От": destination.latitude,
        "До": destination.longitude,
      });
      _markers.add(
        Marker(
          markerId: MarkerId("дистанция"),
          position: destination,
          infoWindow: InfoWindow(title: "Дистанция"),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      _getPolyline();
    });
  }

  void _getPolyline() async {
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCezl0qg1-XiQ_DPOZQyZbSYgXjUssCq5Q",
      PointLatLng(_currentLocation.latitude!, _currentLocation.longitude!),
      PointLatLng(
          _destinationLocation.latitude!, _destinationLocation.longitude!),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId("Маркер"),
          color: Colors.black,
          points: polylineCoordinates,
          width: 5,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 14,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        markers: _markers,
        polylines: _polylines,
        onTap: (LatLng location) {
          _setDestination(location);
        },
      ),
    );
  }
}
