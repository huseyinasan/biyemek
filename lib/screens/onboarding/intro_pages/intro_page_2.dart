import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF9586),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Expanded(
                child: Image.asset(
                  'assets/images/onboarding/intro2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height:10),
            const Text(""),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child:
              Text(
                """     İşletmeler günlük olarak arta 
    kalacağını düşündükleri gıdaları
      listeleyelerek israfı önlerken 
        kazançlarını arttırabilir!""",
                style: TextStyle(
                  fontSize: 22,
                  overflow: TextOverflow.clip,
                  color: Colors.white,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
