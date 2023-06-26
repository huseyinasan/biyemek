
import 'package:biyemek/screens/intro_screens/Introduction_screen.dart';
import 'package:biyemek/screens/login.dart';
import 'package:biyemek/screens/signup.dart';
import 'package:flutter/material.dart';

class entrance extends StatefulWidget {
  const entrance({Key? key}) : super(key: key);

  @override
  State<entrance> createState() => _entranceState();
}

class _entranceState extends State<entrance> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFFE2F3EE),
      body: SingleChildScrollView(
        child: SafeArea(
         child: Center(
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.only(right: 300),
                 child: GestureDetector(
                   onTap: (){
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder:(context){
                           return IntroductionScreen();
                         },
                       ),
                     );
                   },

                   child: Container(
                     width: 50,
                     height: 50,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       shape: BoxShape.circle,
                     ),
                     child: Icon(Icons.arrow_back_ios_new_rounded,
                         color: Color(0xFFE2F3EE)),
                   ),
                 ),
               ),



               const SizedBox(height: 1),
               Image(
                 image: AssetImage('assets/login.png'),
                 width: 500, // İstenilen genişlik
                 height: 300, // İstenilen yükseklik
                 fit: BoxFit.cover, // Resmi sığdırma şekli
               ),
               const SizedBox(height: 20),
               Text(
                   "YEMEĞİ SEV,İSRAFTAN KAÇIN",
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w900,
                 fontStyle: FontStyle.normal,
               ),
               ),
               const SizedBox(height: 10),
               Text('''    Hemen keşfetmeye başla
  sen de bu israfa ortak olma!''',
               style: TextStyle(
                 fontSize: 18,
                 color: Colors.black,
               ),),
               const SizedBox(height: 30),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context){
                        return signup();
                      },
                    ),
                  );
                },

                child: Container(
                  width:350,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFA1E7D2),
                    borderRadius: BorderRadius.circular(30),

                      boxShadow: [
                  BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2, // Gölge yayılma yarıçapı
                  blurRadius: 5, // Gölge bulanıklık yarıçapı
                  offset: Offset(0, 3),
                )
                  ]

                  ),
                  child: Center(
                    child: Text(
                      "Sign up ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height:20 ),
               Container(
                 width: 350,
                 height: 60,

                 decoration: BoxDecoration(
                     color: Color(0xFFE2F3EE),
                     borderRadius: BorderRadius.circular(30),
                     border: Border.all(color: Color(0xFFA1E7D2)),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.5),
                         spreadRadius: 2,
                         blurRadius: 5,
                         offset: Offset(0, 3),
                       )
                     ]
                 ),

                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,

                   children: [
                     Image.asset("assets/google_icon.png"),
                     SizedBox(
                       width: 20,
                     ),
                     Text("Sign up with Google",
                       style: TextStyle(
                           fontSize: 16
                       ),),
                   ],
                 ),
                 alignment: Alignment.bottomLeft,

               ),




               CustomPaint(
                 painter: LinePainter(),
                 size: Size(300, 50),
               ),


               const SizedBox(height: 1),
               GestureDetector(
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder:(context){
                         return login();
                       },
                     ),
                   );
                 },

                 child: Container(
                   width:350,
                   height: 60,
                   decoration: BoxDecoration(
                       color: Color(0xFFA1E7D2),
                       borderRadius: BorderRadius.circular(30),

                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.withOpacity(0.5),
                           spreadRadius: 2, // Gölge yayılma yarıçapı
                           blurRadius: 5, // Gölge bulanıklık yarıçapı
                           offset: Offset(0, 3),
                         )
                       ]

                   ),
                   child: Center(
                     child: Text(
                       "Log in ",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 16,
                       ),
                     ),
                   ),
                 ),
               ),









             ],
           ),
         ),

        ),
      )
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFA1E7D2)
      ..strokeWidth = 1;

    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}