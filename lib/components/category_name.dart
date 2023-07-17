import 'package:biyemek/constants/colors.dart';
import 'package:flutter/material.dart';

class CategoryName extends StatelessWidget {
  final String text;

  const CategoryName({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.local_dining,
          color: Colors.green,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            color: AppColors.figma3Color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
