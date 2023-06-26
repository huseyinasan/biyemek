import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2F3EE),
      body: SafeArea(
        child: Center(

          child: Column(
              children:[
                const SizedBox(height: 100),
                Image.asset(
                  'assets/ıntro1.png',
                  width: 350,
                  height: 350,

                ),
                const SizedBox(height: 20),
                Text("Hoşgeldin BİYEMEK",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green
                ),)
              ]
          ),

        ),

      ),

    );
  }
}
