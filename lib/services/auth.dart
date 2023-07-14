import 'package:biyemek/screens/onboarding/onboarding_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/business_screens/home/business_home_page.dart';
import '../screens/customer_screens/home/customer_homepage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          // User is logged in
          if (snapshot.hasData) {
            String uid = snapshot.data!.uid;

            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('business')
                  .doc(uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // Check if the document exists in the "business" collection
                if (snapshot.hasData && snapshot.data!.exists) {
                  return BusinessHomePage();
                } else {
                  return CustomerHomePage();
                }
              },
            );
          }
          // User is not logged in
          else {
            return const IntroductionScreen();
          }
        },
      ),
    );
  }
}
