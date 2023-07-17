import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomerHomePage extends StatelessWidget {
  CustomerHomePage({super.key});

  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(

        children: [
          Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


          ],
        ),
        ]
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Container(
          width: 130,
          height: 87,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: GNav(
              color: Colors.green,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.green,
              iconSize: 35,
              gap: 5,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Ana Sayfa",
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: "Favoriler",
                ),
                GButton(
                  icon: Icons.shopping_basket_outlined,
                  text: "Siparişlerim",
                ),
                GButton(
                  icon: Icons.shopping_basket_outlined,
                  text: "Sepetim",
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
