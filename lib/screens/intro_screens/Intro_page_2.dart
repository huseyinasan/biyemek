import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {


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
                  'assets/ıntro2.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Text("",
                  style: TextStyle(
                    fontSize: 30,
                  ),)
              ]
          ),

        ),

      ),

    );
  }
}