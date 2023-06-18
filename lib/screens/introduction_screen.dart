import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'Home_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';




class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  final List<PageViewModel> pages = [
    PageViewModel(
        title: "First Page",
        body: "description",
        image: Center(
          child: Image.asset("resimler/ıntro1.png"),
        ),

        decoration: const PageDecoration(
            titleTextStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            )
        )
    ),

    PageViewModel(
        title: "Second Page",
        body: "description",
        image: Center(
          child: Image.asset("resimler/ıntro2.png"),
        ),


        decoration: const PageDecoration(
          titleTextStyle: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),

        )
    ),

    PageViewModel(
        title: "Final Page",
        body: "description",
        image: Center(
          child: Image.asset("resimler/ıntro3.png"),
        ),

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:24.0 ),
          child: IntroductionScreen(

            pages: pages,
            dotsDecorator: const DotsDecorator(
              size: Size(15, 15),
              color: Colors.greenAccent,
              activeSize: Size.square(25),
              activeColor: Colors.green,
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                side: BorderSide(
                    color: Colors.green), // Ok işaretinin kenarlığı
              ),


            ),

            showDoneButton: true,
            done: const Text("Get Started",
              style: TextStyle(fontSize: 15, color: Colors.green),),

            next: const Icon(
              Icons.arrow_forward, size: 20, color: Colors.green,),
            onDone: () => onDone(context),
            curve: Curves.easeInCirc,

          ),
        ),
      );

  }

  void onDone(context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()));
  }
  }
