import 'package:baxi/profile/edit_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.close)),
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const EditProfileScreen();
                    },
                  ));
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                          child: Image.asset(
                            'assets/images/profile.png',
                            width: 80,
                            height: 80,
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      children: [
                        Text(
                          'مهدی رفیعی',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Text('۰۹۱۸۸۹۳۱۷۷۵')
                      ],
                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Icon(
                              CupertinoIcons.forward,
                              size: 18,
                            )))
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                  child: SizedBox(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 60,
                          child: Row(
                            children: [
                              const Icon(CupertinoIcons.bell),
                              const SizedBox(
                                width: 12,
                              ),
                              const Text('پیام ها'),
                              Expanded(
                                  child: Container(
                                alignment: Alignment.centerLeft,
                                child: const Icon(
                                  CupertinoIcons.forward,
                                  size: 18,
                                ),
                              ))
                            ],
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  },
                  itemCount: 4,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
