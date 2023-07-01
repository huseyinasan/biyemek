import 'package:biyemek/screens/home/comments.dart';
import 'package:biyemek/screens/home/location.dart';
import 'package:biyemek/screens/home/products.dart';
import 'package:biyemek/screens/home/profile.dart';
import 'package:biyemek/screens/onboarding/entrance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState(){
    super.initState();
    _pageController=PageController();
  }
  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  Future<void> signUserOut() async {
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
      return const Entrance(); // Return an empty container or another widget
    }
    return SafeArea(
      child: Scaffold(
        body:

        PageView(
          controller: _pageController,
          onPageChanged: (index){
            setState(() {
              _currentIndex=index;

            });
          },

          children:[
            Container(
           color: Color(0xFFFAFAFA),
              child:Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const location();
                            },
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: Colors.green,
                                size: 42,
                              ),
                              Text(
                                "İstanbul/Üsküdar",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const notifications();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                shape: BoxShape.rectangle,
                                color: Colors.black12,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                Icons.notifications,
                                color: Colors.green,
                                size: 42,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                shape: BoxShape.rectangle,
                                color: Colors.green,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "MadGlobal",
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 19),
                                  ),
                                  Icon(
                                    Icons.account_circle_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                                width: 170,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.black12,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Money Saved ",
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                    Icon(
                                      Icons.savings_outlined,
                                      color: Colors.green,
                                      size: 80,
                                    )
                                  ],
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 170,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.black12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "CO2 SAVED",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  Icon(
                                    Icons.co2_sharp,
                                    size: 80,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    "33 Kg",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                shape: BoxShape.rectangle,
                                color: Colors.green,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const comments();
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.mode_comment_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Text(
                                      "Comments",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const products();
                              },
                            ),
                          );
                        },
                        child: Row(
                          children: [Expanded(
                            child: Container(

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                shape: BoxShape.rectangle,
                                color: Colors.green,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "My Products",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                          ],
                        ),
                      ),
                    ),
                    Text("Merhaba ${user.displayName}")
                  ],
                ),
              ),

            ),
            Container(
              color: Color(0xFFFAFAFA),
            ),
            Column(
              children: [
                SizedBox(height: 90),
                GestureDetector(
                  onTap: () { showModalBottomSheet(context: context, builder: (BuildContext){
                    return Container(
                      height: 200,
                      

                      child: Row(
                        children: [
                          SizedBox(width:70 ),
                          Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.green,
                            size: 75,
                          ),

                          SizedBox(width:100 ),

                          Icon(Icons.add_photo_alternate_outlined,
                            color: Colors.green,
                            size: 75,
                          )
                        ],
                      ),

                    );
                  }); },
                  child: Icon(Icons.account_circle,
                      size:150,
                  color: Colors.green),
                ),
                SizedBox(height: 10),
                Text("İşletme Adı",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green
                ),),
                SizedBox(height:50),

                   GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) {
                             return const profile();
                           },
                         ),
                       );
                     },
                     child: Row(

                      children: [
                        SizedBox(width:30 ),
                        Container(


                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.green,
                        ),
                        child: Icon(Icons.account_circle_outlined,
                        size: 40,
                        color: Colors.white,),
                        ),
                        SizedBox(width: 20),
                        Text("Profilimi Düzenle",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width:60 ),
                        Icon(Icons.arrow_forward_ios_rounded,
                          color: Colors.green,)



                      ],
                  ),
                   ),




                SizedBox(height:30),
                GestureDetector(
                  onTap: () { showModalBottomSheet(context: context, builder: (BuildContext){
                    return Container(
                      height: 200,
                      color: Colors.white24,
                      child: Row(
                        children: [
                          SizedBox(width:50 ),
                          Text("Türkçe",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.green
                          ),),
                          SizedBox(width:90 ),
                          Text("English",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.green
                          ),)
                        ],
                      ),
                      
                    );
                  }); },

                  child: Row(

                      children: [
                        SizedBox(width:30 ),
                        Container(

                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.green,
                          ),

                          child: Icon(Icons.language,
                            size: 40,
                            color: Colors.white,),

                        ),
                        SizedBox(width: 20),
                        Text("Dil",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width:190 ),
                        Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.green,)
                      ],
                    ),
                ),

                SizedBox(height:30),

                   GestureDetector(
                     onTap: signUserOut,
                     child: Row(

                         children: [
                           SizedBox(width:30 ),
                           Container(


                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.green,
                            ),
                            child: Icon(Icons.exit_to_app_outlined,
                              size: 40,
                              color: Colors.white,),
                  ),
                           SizedBox(width:20 ),
                           Text("Exit",
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                             color: Colors.green

                           ),),
                           SizedBox(width:180 ),
                           Icon(Icons.arrow_forward_ios_rounded,
                           color: Colors.green,
                           )
                         ],
                       ),
                   ),


              ],
            ),

      ]
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                tabs:  [
                  GButton(



                    icon: Icons.home,
                    text: "Home",
                  ),
                  GButton(

                    icon: Icons.add_shopping_cart,
                    text: "Add Product",
                  ),
                  GButton(

                    icon: Icons.supervisor_account_rounded,
                    text: "Account",
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


