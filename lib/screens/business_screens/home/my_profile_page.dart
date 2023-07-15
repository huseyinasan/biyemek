import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String surname = "";
  int? phoneNumber;
  int? idNumber;
  String businessName = "";
  String businessCity = "";
  String businessDistrict = "";
  int? taxNumber;
  String businessType = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    fetchBusinessData();
  }

  Future<void> fetchBusinessData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String? userEmail = FirebaseAuth.instance.currentUser?.email;

      if (user != null) {
        String uid = user.uid;

        // Fetch the business name from Firestore using the UID
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('business')
            .doc(uid)
            .get();

        // Extract the business name from the document
        String name = snapshot.get('name');
        String surname = snapshot.get('surname');
        int phoneNumber = snapshot.get('phone');
        int idNumber = snapshot.get('idNumber');
        String businessName = snapshot.get('businessName');
        String city = snapshot.get('businessCity');
        String district = snapshot.get('businessDistrict');
        int taxNumber = snapshot.get('taxNumber');
        String businessType = snapshot.get('businessType');

        setState(() {
          name = name;
          surname = surname;
          phoneNumber = phoneNumber;
          idNumber = idNumber;
          businessName = businessName;
          businessCity = city;
          businessDistrict = district;
          taxNumber = taxNumber;
          businessType = businessType;
          email = userEmail!;
        });
      }
    } catch (e) {
      print('Error fetching UID or business name: $e');
    }
  }

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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      "$name $surname",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      "$phoneNumber",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      "$idNumber",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      businessName,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      "$businessCity/$businessDistrict",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      "$taxNumber",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      businessType,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromRGBO(119, 204, 179, 1.0),
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      email,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
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
