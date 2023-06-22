

import 'package:biyemek/screens/intro_screens/%C4%B1ntro_page_1.dart';
import 'package:biyemek/screens/intro_screens/%C4%B1ntro_page_2.dart';
import 'package:biyemek/screens/intro_screens/%C4%B1ntro_page_3.dart';
import 'package:flutter/material.dart';
import 'Home_Screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class IntroductionScreen extends StatefulWidget{
  const IntroductionScreen ({Key? key}):super(key: key);
@override
_IntroductionScreenState createState()=>_IntroductionScreenState();

}
class _IntroductionScreenState extends State<IntroductionScreen>{

  final PageController _controller=PageController();
bool onLastPage=false;



@override
Widget build(BuildContext) {




  return Scaffold(
    body: Stack(
     children :[
       PageView(
         controller: _controller,
        onPageChanged: (index){
         setState(() {
           onLastPage= (index==2);
         });
        },
        children: [
          IntroPage1(),
          IntroPage2(),
          IntroPage3(),

        ],
      ),



       Container(
         alignment: Alignment(0,0.80),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,

             children: [
               GestureDetector(
                 onTap: (){

                   _controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                 },
                 child: Icon(
                   Icons.arrow_back_ios_new_rounded,
                   size: 40,
                   color: Colors.green,
                 ),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   SmoothPageIndicator(
                       controller: _controller,
                       count: 3,
                     effect: WormEffect(
                       dotWidth: 20,
                       dotHeight: 20,

                       dotColor: Colors.greenAccent,
                       activeDotColor: Colors.green,



                     ),
                   ),
                 ],
               ),
               onLastPage ?
               GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) {
                         return HomeScreen();
                       },
                     ),
                   );
                 },
                 child: Container(
                   width: 80,
                   height: 50,
                   decoration: BoxDecoration(
                     color: Colors.green,
                     borderRadius: BorderRadius.circular(20.0),
                     shape: BoxShape.rectangle,
                   ),
                   child: Center(
                     child: Text(
                       "Başla",
                       style: TextStyle(
                         fontSize: 20,
                         color: Colors.greenAccent,
                         fontWeight: FontWeight.bold,

                       ),
                     ),
                   ),
                 ),
               )



                   :
               GestureDetector(
                 onTap: (){
                   _controller.nextPage(duration: (Duration(milliseconds: 500)), curve: Curves.easeIn);
                 },
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Icon(
                       Icons.arrow_forward_ios_rounded,
                       size: 40,
                       color: Colors.green,

                     ),
                   ],
                 ),
               )
             ],
           )),
     ],
    ),
  );
}
}
