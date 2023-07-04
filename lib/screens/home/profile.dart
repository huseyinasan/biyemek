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
              backgroundColor: Colors.green,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Ad Soyad",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "90+ Telefon Numarası",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "TC Kimlik No",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "İşletme Adı",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "İşletme Adresi",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Vergi Numarası",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "İşletme Türü",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "E-mail",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Şifre",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
