import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(

       

      child: Center(
        child: Image.asset(
          'resimler/ıntro1.png',
          fit: BoxFit.cover,
        ),
      ),

      color: Colors.lightGreen,
    );
  }
}
