import 'package:biyemek/firebase_options.dart';
import 'package:biyemek/screens/home/home_screen.dart';
import 'package:biyemek/screens/login/auth.dart';
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
        '/homepage': (context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: "Bi'Yemek",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthPage(),
    );
  }
}
