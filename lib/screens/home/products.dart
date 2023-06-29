import 'package:flutter/material.dart';
class products extends StatefulWidget {
  const products({Key? key}) : super(key: key);

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(

        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),

            child: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    iconDisabledColor: Colors.grey, // Devre dışıyken ikon rengi
                    iconEnabledColor: Colors.green, // Etkinken ikon rengi
                    style: const TextStyle(color: Colors.white),

                    dropdownColor: Colors.green,


                    items: const [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text('Satılan'),
                      ),
                      DropdownMenuItem(
                        value: 'fr',
                        child: Text('Satılmayan'),
                      ),

                    ],
                    onChanged: (value) {

                    },
                  ),
                ),
              ],

              title: const Text(
                "Ürünlerim",
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
