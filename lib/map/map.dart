import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  final MapController mapController;
  final List<Widget>? mapChildren;
  final double? zoom;
  const MapWidget(
      {super.key, required this.mapController, this.mapChildren, this.zoom});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  static const LatLng hamedanPosition = LatLng(34.798140, 48.514689);
  double? userlat;
  double? userlng;

  @override
  void initState() {
    super.initState();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Services Are Disabled!');
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions Are Denied!');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permissions Are Denied Permanently!");
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((event) {
      userlat = event.latitude;
      userlng = event.longitude;
      // mapController.move(LatLng(userlat, userlng), 16);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        initialCenter: hamedanPosition,
        initialZoom: widget.zoom ?? 15,
        zoom: widget.zoom ?? 15
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        if (widget.mapChildren != null) ...widget.mapChildren!
      ],
    )));
  }
}
