import 'package:baxi/map/map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  final MapController mapController = MapController();
  double? userlat;
  double? userlng;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation().then((value) {
      userlat = value.latitude;
      userlng = value.longitude;
      setState(() {});
      mapController.move(LatLng(userlat!, userlng!), 15);
    });
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
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final location = await _getCurrentLocation();
              mapController.move(
                  LatLng(location.latitude, location.longitude), 15);
            },
            label: Icon(CupertinoIcons.location)),
        body: MapWidget(
          mapController: mapController,
          mapChildren: [
            MarkerLayer(markers: [
              if (userlat != null && userlng != null)
                Marker(
                    point: LatLng(userlat!, userlng!),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 26, 255),
                              width: 4),
                          shape: BoxShape.circle),
                    ))
            ])
          ],
        ),
      ),
    );
  }
}
