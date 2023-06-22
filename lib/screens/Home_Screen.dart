import 'package:biyemek/screens/comments.dart';
import 'package:biyemek/screens/location.dart';
import 'package:biyemek/screens/products.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'Bildirimler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
  class _HomeScreenState extends State<HomeScreen>{





    @override
  Widget build(BuildContext context){
  return
    SafeArea(

      child: Scaffold(


        body: Padding(

          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return location();
                      },
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: const [
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
                              return Bildirimler();
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
                        padding: EdgeInsets.all(5),
                        child: Icon(
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
                    Container(
                      width: 360,
                      height: 50,

                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20.0),
                        shape: BoxShape.rectangle,
                        color: Colors.green,

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: const [
                          Text(
                            "MadGlobal",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19
                            ),
                          ),
                          Icon(
                                Icons.account_circle_outlined,
                              size: 40,
                            color: Colors.white,
                          ),

                        ],
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
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.black12,
                          ),
                            child:Column(
                            children: const [
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
                           )


                        )
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
                          children: const [
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
                    Container(
                      width: 360,
                      height: 50,
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
                                return comments();
                              },
                            ),
                          );
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
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
                          return products();
                        },
                      ),
                    );
                  },

                  child: Row(
                    children: [
                      Container(
                        width: 360,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          shape: BoxShape.rectangle,
                          color: Colors.green,

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
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

                    ],
                  ),
                ),
              ),



            ],


          ),
        ),
       bottomNavigationBar:Padding(
         padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),

       child:Container(
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
        padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),

        child: GNav(


          color: Colors.green,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.green,

          iconSize: 35,
          gap: 5,
        onTabChange: (index){
            print("index");
        },
        padding: EdgeInsets.all(16),
        tabs: const [

          GButton(

              icon: Icons.home,
              text :"Home",
          ),
        GButton(
            icon: Icons.add_shopping_cart,
            text :"Add Product",
        ),
        GButton(
            icon: Icons.supervisor_account_rounded,
            text :"Account",
             ),
              ],
                    ),
                   ),
                 ),
               ),
             ),
           );

    }
  }
