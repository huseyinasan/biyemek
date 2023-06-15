import 'package:biyemek/screens/Home_Screen.dart';
import 'package:biyemek/screens/introduction_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext){
    return MaterialApp(
      title: "BiYemek",
      theme: ThemeData(
        primarySwatch:Colors.blue

    ),
      home: IntroScreen(),

    );
  }
}
