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
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Okunmuş'),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('Okunmamış'),
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
              title: const Text(
                "Bildirimler",
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
