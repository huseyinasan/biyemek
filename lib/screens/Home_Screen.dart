import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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

       bottomNavigationBar:Padding(
         padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),

       child:Container(
         width: 130,
          height: 87,


      decoration: BoxDecoration(
        border: Border.all(

          color: Colors.green,
          width: 3.0,
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
        tabs: [

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
