import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFADDE85),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 60),

              Image.asset(
                'assets/images/onboarding/intro1.png',
                width: 400,
                height: 400,
              ),
               SizedBox(height: 10),
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    Text(
                      "Bi'Yemek",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(height:20 ),
                    Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
