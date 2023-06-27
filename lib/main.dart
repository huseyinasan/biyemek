import 'package:biyemek/screens/intro_screens/introduction_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bi'Yemek",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const IntroductionScreen(),
    );
  }
}
