import 'package:biyemek/constants/colors.dart';
import 'package:biyemek/screens/onboarding/entrances/business_entrance.dart';
import 'package:biyemek/screens/onboarding/entrances/customer_entrance.dart';
import 'package:flutter/material.dart';

class ChooseEntrance extends StatelessWidget {
  const ChooseEntrance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CustomerEntrance();
                    },
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 3 / 5,
                width: MediaQuery.of(context).size.width,
                color: AppColors.secondaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "İsrafa karşı savaşan bir müşteri misiniz?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Buraya Tıklayın! ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10.0),
                      shadowColor: Colors.grey,
                      child: Container(
                        width: 200,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // border color
                            width: 3.0, // border width
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Image.asset(
                          "assets/images/onboarding/customer_choose_image.png",
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BusinessEntrance();
                      },
                    ),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 2 / 5,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "İsrafa karşı savaşan bir işletme misiniz?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Buraya Tıklayın! ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                          child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.grey,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // border color
                              width: 3.0, // border width
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            width: 200,
                            height: 150,
                            child: Image.asset(
                              "assets/images/onboarding/intro2.png",
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
