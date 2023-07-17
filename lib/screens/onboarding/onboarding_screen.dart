import 'package:biyemek/constants/colors.dart';
import 'package:biyemek/screens/onboarding/entrances/choose_entrance.dart';
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
            slideIconWidget: currentIndex == 2
                ? Container()
                : const Icon(Icons.arrow_back_ios_new_rounded),
            pages: [
              //first page
              Container(
                color: Colors.greenAccent,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Image.asset("assets/images/onboarding/intro1.png"),
                    const Text(
                      "Bi'Yemek",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      """İsrafı önlemenin en ucuz ve taze hali""",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              //second page
              Container(
                color: Colors.pinkAccent,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset("assets/images/onboarding/intro2.png"),
                    const Text(
                      "İşletmeler",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Gıda ürünlerini listeleyelerek hem gıda israfını hem de mali zararı önleyebilir!",
                          style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.clip,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //third page
              Container(
                color: Colors.yellow,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset("assets/images/onboarding/intro3.png"),
                    const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Gıda ürünlerini çok uygun fiyatlara satın al ve israfın önüne geç!",
                          style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.clip,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ChooseEntrance();
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.tertiaryColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Başla",
                              style: TextStyle(
                                fontSize: 16,
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
