import 'package:baxi/profile/profile.dart';
import 'package:baxi/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> sectionImages = [
      "assets/images/baxi_section.png",
      "assets/images/female_section.png",
      "assets/images/delivery_section.png",
      "assets/images/freight_section.png"
    ];
    List<String> sectionNames = [
      "بکسی",
      "بکسی بانوان",
      "بکسی باکس",
      "بکسی بار"
    ];
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  alignment: Alignment.centerRight,
                  height: 200,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.grey, blurRadius: 10)
                      ],
                      color: Colors.yellow,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(135))),
                  child: SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'بکسی از آن توست!',
                          style: theme.textTheme.headlineSmall,
                        )
                            .animate()
                            .fade(
                                duration: const Duration(seconds: 1),
                                delay: const Duration(seconds: 1))
                            .slide()
                            .then()
                            .shake(
                                curve: Curves.linear,
                                hz: 75,
                                duration: const Duration(seconds: 1)),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'با چشم به هم زدن در خدمت شما خواهیم بود.',
                          style: theme.textTheme.bodyLarge!.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.9)),
                          textAlign: TextAlign.start,
                        ).animate().fade(
                            duration: const Duration(milliseconds: 500),
                            delay: const Duration(seconds: 1)),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: -20,
                  child: Image.asset(
                    'assets/images/baxi.png',
                    width: 200,
                    height: 200,
                  ).animate().slideX(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 500)),
                ),
                Positioned(
                    right: 20,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const ProfileScreen();
                        },));
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(color: Colors.grey, blurRadius: 10)
                            ],
                            border: Border.all(
                                color: theme.colorScheme.onPrimary, width: 1)),
                          child: const Icon(Icons.more_horiz),
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            GridView.builder(
              padding: const EdgeInsets.only(left: 25, right: 25),
              itemCount: 4,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    switch(index) {
                      case 0:
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return const SearchScreen();
                        },));
                      break;
                      case 1:
                      break;
                      case 2:
                      break;
                      case 3:
                      break;
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3), blurRadius: 10)
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          sectionImages[index],
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          sectionNames[index],
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: searchBox(context),
            )
          ],
        ),
      )),
    );
  }

  Widget searchBox(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return const SearchScreen();
          },
        ));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12),
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10)
            ]),
        child: const Row(
          children: [
            Icon(CupertinoIcons.search),
            SizedBox(
              width: 8,
            ),
            Text('به کجا می روید؟')
          ],
        ),
      ),
    );
  }
}
