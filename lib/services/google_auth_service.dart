import 'package:biyemek/screens/onboarding/entrances/choose_entrance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/customer_screens/home/customer_homepage.dart';

class AuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser != null) {
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // ignore: unnecessary_null_comparison
      if (userCredential != null) {
        // Navigate to the user's homepage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CustomerHomePage();
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const ChooseEntrance();
            },
          ),
        );
      }
    }
  }
}
