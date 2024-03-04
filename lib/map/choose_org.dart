import 'package:baxi/bottomsheets/baxi_bar_bottom_sheet.dart';
import 'package:baxi/bottomsheets/baxi_box_bottom_sheet.dart';
import 'package:baxi/map/choose_des.dart';
import 'package:baxi/map/map.dart';
import 'package:baxi/map/map_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class ChooseOriginScreen extends StatefulWidget {
  final String service;
  const ChooseOriginScreen({super.key, required this.service});

  @override
  State<ChooseOriginScreen> createState() => _ChooseOriginScreenState();
}

class _ChooseOriginScreenState extends State<ChooseOriginScreen> {
  final MapController mapController = MapController();
  final TextEditingController searchController = TextEditingController();
  double? userlat;
  double? userlng;

  Map<String, int> services = {
    'baxi': 0,
    'baxi_female': 1,
    'baxi_box': 2,
    'baxi_bar': 3
  };

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Positioned.fill(
              child: MapWidget(
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
          )),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              decoration:
                  BoxDecoration(color: theme.colorScheme.surface, boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.4), blurRadius: 10)
              ]),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 8),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextField(
                                  onEditingComplete: () async {
                                    try {
                                      final searchedLocation =
                                          await MapService.addressToLocation(
                                              searchController.text,
                                              userlat!,
                                              userlng!);
                                      mapController.move(searchedLocation, 15);
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                  },
                                  controller: searchController,
                                  decoration: const InputDecoration(
                                      hintText: 'کجا هستید؟',
                                      contentPadding:
                                          EdgeInsets.only(left: 12, right: 12)),
                                ))
                            .animate()
                            .slideY(
                                duration: const Duration(milliseconds: 500)))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        _getCurrentLocation().then((value) {
                          userlat = value.latitude;
                          userlng = value.longitude;
                          setState(() {});
                          mapController.move(LatLng(userlat!, userlng!), 15);
                        });
                      },
                      child: const Icon(CupertinoIcons.location),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            LatLng location = mapController.camera.center;
                            userlat = location.latitude;
                            userlng = location.longitude;
                            if (services[widget.service] == 2) {
                              await showModalBottomSheet(
                                isDismissible: false,
                                enableDrag: false,
                                context: context,
                                builder: (context) =>
                                    const BaxiBoxBottomSheet(),
                              );
                            } else if(services[widget.service] == 3) {
                                await showModalBottomSheet(
                                isDismissible: false,
                                enableDrag: false,
                                context: context,
                                builder: (context) =>
                                    const BaxiBarBottomSheet(),
                              );
                            }
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ChooseDestinationScreen(
                                    userlat: userlat!, userlng: userlng!);
                              },
                            ));
                          },
                          child: Text(
                            'تایید مبدا',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              )),
          // Center(child: Image.asset('assets/images/destination_locator.png', width: 70, height: 70,),)
          Positioned(
            child: Image.asset(
              'assets/images/origin_locator.png',
              width: 70,
              height: 70,
            ),
            left: MediaQuery.of(context).size.width / 2 - 35,
            right: MediaQuery.of(context).size.width / 2 - 35,
            bottom: MediaQuery.of(context).size.height / 2,
            top: MediaQuery.of(context).size.height / 2 - 70,
          )
        ]),
      ),
    );
  }
}
