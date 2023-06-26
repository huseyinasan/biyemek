import 'package:flutter/material.dart';
class notifications extends StatefulWidget {
  const notifications({Key? key}) : super(key: key);

  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),

            child: AppBar(
              actions: [
                PopupMenuButton(
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text('Okunmuş'),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Okunmamış'),
                        value: 2,
                      ),

                    ];
                  },
                  onSelected: (value) {
                    if (value == 1) {

                    } else if (value == 2) {

                    }


                  },
                ),
              ],
              title: Text(
                "Bildirimler",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),),

              iconTheme: IconThemeData(
                color: Colors.green,
              ),


              backgroundColor: Color(0xFFEDECF5),

            ),
          ),


        ],
      ),
    );
  }
}
