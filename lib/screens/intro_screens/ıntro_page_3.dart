import 'package:flutter/material.dart';


class IntroPage3 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          'resimler/ıntro3.png',
          fit: BoxFit.cover,
        ),
      ),
      color: Colors.lightGreen,
    );
  }
}