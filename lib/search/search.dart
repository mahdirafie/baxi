import 'package:animations/animations.dart';
import 'package:baxi/custom/animated_text_field.dart';
import 'package:baxi/map/choose_des.dart';
import 'package:baxi/map/choose_org.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:latlong2/latlong.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  bool destinationSelected = false;
  LatLng? originLocation;
  LatLng? destinationLocation;

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      if (_focusNode1.hasFocus) {
        destinationSelected = false;
        setState(() {});
      }
    });
    _focusNode2.addListener(() {
      if (_focusNode2.hasFocus) {
        destinationSelected = true;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
              child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back)),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                children: [
                  Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 700),
                        width: destinationSelected ? 8 : 10,
                        height: destinationSelected ? 8 : 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: !destinationSelected
                                ? Colors.black
                                : Colors.grey),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 700),
                        width: !destinationSelected ? 8 : 10,
                        height: !destinationSelected ? 8 : 10,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: destinationSelected
                                ? Colors.black
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(2)),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width: !destinationSelected
                                    ? MediaQuery.of(context).size.width
                                    : MediaQuery.of(context).size.width / 2,
                                height: 50,
                                child: AnimatedTextField(
                                  hintText: 'مبدا',
                                  focusNode: _focusNode1,
                                  suffix: OpenContainer(
                                    transitionDuration: const Duration(seconds: 1),
                                    transitionType:
                                        ContainerTransitionType.fadeThrough,
                                    openColor: theme.colorScheme.primary,
                                    closedColor: theme.colorScheme.onPrimary,
                                    closedBuilder: (context, action) {
                                      return Image.asset(
                                        'assets/images/map.png',
                                        width: 35,
                                        height: 35,
                                      );
                                    },
                                    openBuilder: (context, action) {
                                      return const ChooseOriginScreen();
                                    },
                                  ),
                                ))
                            .animate()
                            .fade()
                            .slideY(
                                duration: const Duration(milliseconds: 500)),
                        const SizedBox(
                          height: 12,
                        ),
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: destinationSelected
                                ? MediaQuery.of(context).size.width
                                : MediaQuery.of(context).size.width / 2,
                            height: 50,
                            child: AnimatedTextField(
                                hintText: 'مقصد',
                                focusNode: _focusNode2,
                                suffix: OpenContainer(
                                  transitionDuration: const Duration(seconds: 1),
                                  transitionType:
                                      ContainerTransitionType.fadeThrough,
                                  openColor: theme.colorScheme.primary,
                                  closedColor: theme.colorScheme.onPrimary,
                                  closedBuilder: (context, action) {
                                    return Image.asset(
                                      'assets/images/map.png',
                                      width: 35,
                                      height: 35,
                                    );
                                  },
                                  openBuilder: (context, action) {
                                    return const ChooseDestinationScreen(
                                        userlat: 34.97263, userlng: 48.656382);
                                  },
                                ))).animate().fade().slideY(
                            duration: const Duration(milliseconds: 500)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Divider(),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 16, bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary),
                      child: const Center(
                          child: Icon(
                        CupertinoIcons.bookmark,
                        size: 20,
                      )),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'لیست مکان های منتخب',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              CupertinoIcons.forward,
                              size: 20,
                            ))),
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
                child: SizedBox(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 8, bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.history),
                          const SizedBox(
                            width: 12,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'اراک',
                                ),
                                Text(
                                  'شهر اراک ,اراک',
                                  style: theme.textTheme.bodySmall,
                                )
                              ],
                            ),
                          ),
                          Text(
                            '۱۳۷ کیلومتر',
                            style: theme.textTheme.bodySmall!
                                .copyWith(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
