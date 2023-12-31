import 'package:biyemek/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final VoidCallback onTap;

  CustomAppBar({super.key, required this.onTap})
      : super(
          backgroundColor: AppColors.figma1Color,
          automaticallyImplyLeading: false,
          title: Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Bi'Yemek",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onTap,
                    child: const Icon(
                      Icons.person_2_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}
