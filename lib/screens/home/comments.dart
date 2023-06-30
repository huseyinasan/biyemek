import 'package:flutter/material.dart';
class comments extends StatefulWidget {
  const comments({Key? key}) : super(key: key);

  @override
  State<comments> createState() => _commentsState();
}

class _commentsState extends State<comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(

          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),

              child: AppBar(
                title: const Text(
                  "Yorumlar",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),),

                iconTheme: const IconThemeData(
                  color: Colors.green,
                ),


                backgroundColor: const Color(0xFFEDECF5),

              ),
            ),


          ],
        ),
    );
  }
}
