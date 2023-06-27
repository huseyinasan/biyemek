import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2F3EE),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/ıntro2.png',
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "İşletme sahipleri günlük olarak arta kalacağını düşündükleri gıdaları listeleyelerek israfı önlerken kazançlarını arttırabilir!",
                style: TextStyle(
                  fontSize: 24,
                  overflow: TextOverflow.clip,
                  color: Colors.green,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
