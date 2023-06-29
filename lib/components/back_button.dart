import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final Function()? onTap;

  BackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Color(0xFFE2F3EE)),
      ),
    );
  }
}
