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
            color: Color(0xFFFF5722),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
