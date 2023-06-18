import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Image.asset(
          'resimler/ıntro2.png',
          fit: BoxFit.cover,
        ),
      ),
      color: Colors.lightGreen,
    );
  }
}