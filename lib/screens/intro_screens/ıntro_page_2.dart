import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
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