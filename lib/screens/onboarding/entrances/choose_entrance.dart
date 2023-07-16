import 'package:biyemek/screens/onboarding/entrances/business_entrance.dart';
import 'package:flutter/material.dart';
import 'customer_entrance.dart';

class ChooseEntrance extends StatefulWidget {
  const ChooseEntrance({Key? key}) : super(key: key);

  @override
  State<ChooseEntrance> createState() => _ChooseEntranceState();
}

class _ChooseEntranceState extends State<ChooseEntrance> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.yellow,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: screenWidth,
              height: screenHeight / 2,
              color: Colors.pink,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: screenWidth,
              height: screenHeight / 2,
              color: Colors.orange,
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        // İşletme girişi işlemleri
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            size: 60.0,
                            color: Colors.pink,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'İşletme Girişi',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: () {
                        // Müşteri girişi işlemleri
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_basket,
                            size: 60.0,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Müşteri Girişi',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
