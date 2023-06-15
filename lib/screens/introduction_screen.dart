import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'Home_Screen.dart';

class IntroScreen extends StatelessWidget {
   IntroScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages=[
    PageViewModel(
        title:"First Page",
        body:"description",

  decoration: const PageDecoration(
  titleTextStyle: TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  )
   )
    ),


    PageViewModel(
        title:"Second Page",
        body:"description",

        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            )
        )
    ),

    PageViewModel(
        title:"Final Page",
        body:"description",

        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            )
        )
    ),


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IntroductionScreen(
        pages:pages,
        dotsDecorator: const DotsDecorator(
          size: Size(15, 15),
          color: Colors.greenAccent,
          activeSize: Size.square(15),
          activeColor: Colors.green,
        ),
        showDoneButton: true,
        done: const Text("Get Started", style: TextStyle(fontSize: 15,color: Colors.green),),

        next:const Icon(
          Icons.arrow_forward, size: 20,color: Colors.green,),
          onDone:() => onDone(context),


      ),
    );
  }
  void onDone (context){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()));
  }
}