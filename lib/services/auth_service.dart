import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      // Check if the sign-in was successful
      if (userCredential != null) {
        // Navigate to the user's homepage
        Navigator.pushReplacementNamed(context, '/homepage');
      } else {
        // Handle sign-in error
        // ...
      }
    } else {
      // Handle case when user cancels Google sign-in
      // ...
    }
  }
}
