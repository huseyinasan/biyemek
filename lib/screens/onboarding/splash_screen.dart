import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../services/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/onboarding/intro1.png"),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SpinKitThreeInOut(
                color: Colors.red,
                size: 50.0,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.greenAccent,
      nextScreen: const AuthPage(),
      splashIconSize: 500,
      duration: 3000,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
