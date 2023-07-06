import 'package:biyemek/firebase_options.dart';
import 'package:biyemek/screens/business_screens/home/home_screen.dart';
import 'package:biyemek/services/already_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
        '/homepage': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: "Bi'Yemek",
      home: const AuthPage(),
    );
  }
}
