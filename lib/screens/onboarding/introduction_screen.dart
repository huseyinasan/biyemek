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
  final _controller = LiquidController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            liquidController: _controller,
            onPageChangeCallback: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            enableLoop: false,
            enableSideReveal: true,


            slideIconWidget: currentIndex == 2 ? Container() : Icon(Icons.arrow_back_ios_new_rounded),
            pages: [
              Container(
                color: Colors.greenAccent,
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset("assets/images/onboarding/intro1.png"),
                  ],
                ),
              ),
              Container(
                color: Colors.pinkAccent,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Image.asset("assets/images/onboarding/intro2.png"),
                  ],
                ),
              ),
              Container(
                color: Colors.yellow,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Image.asset("assets/images/onboarding/intro3.png"),
                    SizedBox(height: 200),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Choose_register();
                            },
                          ),
                        );
                      },
                      child: Expanded(
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Başla",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedSmoothIndicator(
                  activeIndex: _controller.currentPage,
                  count: 3,
                  effect: const WormEffect(
                    spacing: 16,
                    dotColor: Colors.white54,
                    activeDotColor: Colors.white,
                  ),
                  onDotClicked: (index) {
                    _controller.animateToPage(page: index);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
