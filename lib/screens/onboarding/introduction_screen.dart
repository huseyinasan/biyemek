import 'package:biyemek/screens/register/Choose_register.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final _controller= LiquidController();
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
          liquidController: _controller,
          onPageChangeCallback: (value) {
            setState(() {
              currentIndex=value;
            });
         },

          enableLoop: false,
          enableSideReveal: true,
          slideIconWidget: Icon(Icons.arrow_back_ios_new_rounded),
          pages: [
            Container(
              color:  Colors.greenAccent,

            ),
            Container(
              color:  Colors.pinkAccent,

            ),
            Container(
              color: Colors.yellow,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  {
                    return Choose_register();
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    )
                  ),
                  child: Text("Başla"),

                ),
              ),




            ),

          ],

        ),
          Positioned(
            bottom: 0,
            left: 100,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               AnimatedSmoothIndicator(activeIndex: _controller.currentPage, count: 3,
               effect: const WormEffect(
                 spacing: 16,
                 dotColor: Colors.white54,
                 activeDotColor: Colors.white,
               ),
               onDotClicked: (index){
                 _controller.animateToPage(page: index);
               },)
              ],
            ),
          )
      ]
      ),


    );
  }
}

