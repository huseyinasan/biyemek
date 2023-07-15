import 'package:biyemek/screens/onboarding/entrances/customer_entrance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int currentStep = 0;
  final statuses = List.generate(
    2,
    (index) => SizedBox.square(
      dimension: 32,
      child: Center(child: Text('$index')),
    ),
  );

  int curIndex = -1;
  int lastIndex = -1;
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> signUserOut() async {
    // çıkış yapma
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not signed in, handle this case accordingly
      return const CustomerEntrance(); // Return an empty container or another widget
    }

    return SafeArea(
      child: Scaffold(
        body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                "Bi'Yemek",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // yönlendirme yap
                              },
                              child: Icon(Icons.person_2_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "sayfa2",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 30, // yazı büyüklüğü
                      fontWeight: FontWeight.normal, //kalınlık
                    ),
                  )
                ],
              ),
              Column(
                children: [Text("sayfa3")],
              ),
            ]),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Container(
            width: 130,
            height: 87,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.pink,
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
                    icon: Icons.shopping_basket,
                    text: "Sepetim",
                  ),
                  GButton(
                    icon: Icons.food_bank_outlined,
                    text: "Siparişlerim",
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    _pageController.jumpToPage(index);
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
