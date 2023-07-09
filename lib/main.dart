import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:biyemek/firebase_options.dart';
import 'package:biyemek/screens/business_screens/home/business_home_page.dart';
import 'package:biyemek/screens/onboarding/onboarding_screen.dart';
import 'package:biyemek/services/already_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext) {
    return MaterialApp(
      routes: {
        '/homepage': (context) => const BusinessHomePage(),
      },
      debugShowCheckedModeBanner: false,
      title: "Bi'Yemek",
      home: const SplashScreen(),
    );
  }
}
 
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(

        splash: Column(

         children: [
           Image.asset("assets/images/onboarding/intro1.png"),

          SizedBox(height: 30),
          SpinKitThreeInOut(
           color: Colors.red,
           size: 50.0,


          )

         ],
        ),
        backgroundColor: Colors.greenAccent,
        nextScreen: AuthPage(),
    splashIconSize: 500,
      duration: 4000,
      splashTransition:SplashTransition.slideTransition ,
    );

  }
}
