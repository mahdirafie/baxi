import 'package:baxi/map/map.dart';
import 'package:baxi/map/map_model.dart';
import 'package:baxi/map/map_service.dart';
import 'package:baxi/map/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:latlong2/latlong.dart';

class ChooseDestinationScreen extends StatefulWidget {
  final double userlat;
  final double userlng;
  const ChooseDestinationScreen(
      {super.key, required this.userlat, required this.userlng});

  @override
  State<ChooseDestinationScreen> createState() =>
      _ChooseDestinationScreenState();
}

class _ChooseDestinationScreenState extends State<ChooseDestinationScreen> {
  final MapController mapController = MapController();
  final TextEditingController searchController = TextEditingController();
  LatLng? desLocation;
  List<LatLng> routingPoints = [];
  MapDTO? result;
  double zoom = 15;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Positioned.fill(
              child: MapWidget(
            zoom: zoom,
            mapController: mapController,
            mapChildren: [
              MarkerLayer(markers: [
                Marker(
                    point: LatLng(widget.userlat, widget.userlng),
                    child: Image.asset(
                      'assets/images/origin_locator.png',
                      width: 70,
                      height: 70,
                    )),
                if (desLocation != null)
                  Marker(
                      point: desLocation!,
                      child: Image.asset(
                        'assets/images/destination_locator.png',
                        width: 70,
                        height: 70,
                      ))
              ]),
              if (routingPoints.isNotEmpty)
                PolylineLayer(polylines: [
                  Polyline(
                      points: routingPoints,
                      strokeWidth: 5,
                      color: theme.colorScheme.onPrimary),
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
                    GestureDetector(onTap: () {
                      Navigator.of(context).pop();
                    },child: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: TextField(
                                  controller: searchController,
                                  onEditingComplete: () async{
                                    try{
                                      final searchedLocation = await MapService.addressToLocation(searchController.text, widget.userlat, widget.userlng);
                                      mapController.move(searchedLocation, 15);
                                    }catch(e) {
                                      debugPrint(e.toString());
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      hintText: 'به کجا میروید؟',
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
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (desLocation == null) {
                          try {
                            desLocation = mapController.camera.center;
                            result = await MapService.getDirections(
                                LatLng(widget.userlat, widget.userlng),
                                desLocation!,
                                true);
                            routingPoints =
                                decodePolyline(result!.points).unpackPolyline();
                            zoom = 10;
                            setState(() {});
                            _showBottomSheet();
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        }else {
                          _showBottomSheet();
                        }
                      },
                      child: Text(
                        desLocation == null?
                        'تایید مقصد': 'مشاهده جزيیات',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      )),
                ),
              )),
          if (desLocation == null)
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 35,
              right: MediaQuery.of(context).size.width / 2 - 35,
              bottom: MediaQuery.of(context).size.height / 2,
              top: MediaQuery.of(context).size.height / 2 - 70,
              child: Image.asset(
                'assets/images/destination_locator.png',
                width: 70,
                height: 70,
              ),
            )
        ]),
      ),
    );
  }

  Future<void> _showBottomSheet() async {
    final theme = Theme.of(context);
    return await showModalBottomSheet(
      barrierColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: theme.colorScheme.surface,
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25), topRight: Radius.circular(12))),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: theme.colorScheme.onPrimary.withOpacity(0.5)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 40),
                      child: Row(
                        textDirection: TextDirection.ltr,
                        children: [
                          Image.asset(
                            'assets/images/baxi.png',
                            width: 70,
                            height: 70,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            'بکسی',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    if (result != null)
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('توضیحات: ',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(
                              result!.summary,
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                      ),
                    if (result != null)
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('زمان تقریبی: ',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold)),
                            Expanded(
                                child: Text(
                              result!.duration,
                              textAlign: TextAlign.left,
                            )),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 12, 25, 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('هزینه سفر: ',
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Text(
                            '۱۳۰۰۰ تومان',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    )
                  ],
                ),
              ),
            ),
            Positioned(bottom: 25, right: 25, left: 25,child: ElevatedButton(onPressed: () {
              
            }, child: Text('تایید سرویس', style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),)))
          ],
        );
      },
    );
  }
}
