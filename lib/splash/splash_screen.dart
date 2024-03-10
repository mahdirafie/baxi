import 'package:baxi/auth/input_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const InputPhoneNumberScreen();
          },
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Lottie.asset('assets/animations/baxi_animation.json',
                width: 200, height: 200),
          ),
          Positioned(
            bottom: 40, right: 0, left: 0,
              child: Center(
                child: Text(
                            'رفیع',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nastaliq',
                  fontSize: 50,
                  color: Colors.black),
                          ),
              ))
        ],
      ),
    );
  }
}
