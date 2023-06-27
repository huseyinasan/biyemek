import 'dart:ui';
import 'package:flutter/material.dart';
import '../onboarding/customer_entrance.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2F3EE),
      body: ListView(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const entrance();
                      },
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 300),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              const SizedBox(height: 20),
              const Image(
                image: AssetImage('assets/images/onboarding/login.png'),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Color(0xFFA1E7D2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      "Log in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
