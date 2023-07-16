import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key? key}) : super(key: key);

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
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
        String fsName = snapshot.get('name');
        String fsSurname = snapshot.get('surname');
        int fsPhoneNumber = snapshot.get('phone');
        int fsIdNumber = snapshot.get('idNumber');
        String fsBusinessName = snapshot.get('businessName');
        String fsCity = snapshot.get('businessCity');
        String fsDistrict = snapshot.get('businessDistrict');
        int fsTaxNumber = snapshot.get('taxNumber');
        String fsBusinessType = snapshot.get('businessType');

        setState(() {
          name = fsName;
          surname = fsSurname;
          phoneNumber = fsPhoneNumber;
          idNumber = fsIdNumber;
          businessName = fsBusinessName;
          businessCity = fsCity;
          businessDistrict = fsDistrict;
          taxNumber = fsTaxNumber;
          businessType = fsBusinessType;
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
