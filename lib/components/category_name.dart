import 'package:flutter/material.dart';

class CategoryName extends StatelessWidget {
  final String text;

  CategoryName({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.local_dining,
          color: Colors.green,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
