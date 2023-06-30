import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2F3EE),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Image.asset(
                  'assets/images/onboarding/intro3.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Günlük olarak listelenen fazlalık taze ürünleri çok uygun fiyatlara satın al ve israfın önüne geç!",
                  style: TextStyle(
                    fontSize: 24,
                    overflow: TextOverflow.clip,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
