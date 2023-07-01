import 'package:flutter/material.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: AppBar(
              title: const Text(
                "Hesabım",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor:  Colors.green,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30,right: 30),
            child: Expanded(

                child:
                  Column(
                    children: [
                      Container(
                        height: 50,

                        child:     Padding(
                          padding: const EdgeInsets.only(left: 20,top: 10),
                          child: Text("Ad Soyad",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          ),),
                        ),


                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(119, 204, 179, 1.0),
                          shape: BoxShape.rectangle,

                        ),

                      ),

                      Container(
                        height: 50,

                        child:     Padding(
                          padding: const EdgeInsets.only(left: 20,top: 10),
                          child: Text("Ad Soyad",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),),
                        ),


                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromRGBO(119, 204, 179, 1.0),
                          shape: BoxShape.rectangle,

                        ),

                      ),
                    ],
                  ),





            ),
          )
        ],
      ),
    );
  }
}
