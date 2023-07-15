import 'package:biyemek/screens/customer_screens/home/customer_old_orders.dart';
import 'package:biyemek/screens/customer_screens/home/my_profile_customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerProfilePage extends StatefulWidget {
  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {});
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext) {
                            return SizedBox(
                              height: 200,
                              child: Row(
                                children: [
                                  SizedBox(width: 70),
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.pink,
                                    size: 75,
                                  ),
                                  SizedBox(width: 100),
                                  Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: Colors.pink,
                                    size: 75,
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: const Icon(Icons.account_circle,
                        size: 150, color: Colors.pink),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CustomerProfile();
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.pink,
                          ),
                          child: const Icon(
                            Icons.account_circle_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Bilgilerim",
                          style: TextStyle(
                              color: Colors.pink,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 60),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.pink,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return OldOrdersPage();
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.pink,
                          ),
                          child: const Icon(
                            Icons.food_bank,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Geçmiş siparişlerim",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.pink,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 40),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.pink,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: signUserOut,
                    child: Expanded(
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.pink,
                            ),
                            child: const Icon(
                              Icons.exit_to_app_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            "Çıkış Yap",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink),
                          ),
                          const SizedBox(width: 130),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.pink,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
