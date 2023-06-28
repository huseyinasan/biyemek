import 'package:biyemek/screens/home/home_screen.dart';
import 'package:biyemek/screens/onboarding/introduction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is logged in
          if (snapshot.hasData) {
            return HomeScreen();
          }
          //user is not logged in
          else {
            return IntroductionScreen();
          }
        },
      ),
    );
  }
}
