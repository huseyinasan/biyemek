import 'package:flutter/material.dart';


class IntroPage3 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Center(
        child: Image.asset(
          'assets/ıntro3.png',
          fit: BoxFit.cover,
        ),
      ),
      color: Colors.lightGreen,
    );
  }
}