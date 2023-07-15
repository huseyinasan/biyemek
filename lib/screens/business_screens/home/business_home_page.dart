import 'dart:io';
import 'package:biyemek/screens/business_screens/home/comments.dart';
import 'package:biyemek/screens/business_screens/home/my_products_page.dart';
import 'package:biyemek/screens/business_screens/home/my_profile_page.dart';
import 'package:biyemek/screens/onboarding/entrances/business_entrance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uuid/uuid.dart';
import '../../../services/my_products_service.dart';
import 'add_product_completed.dart';
import 'notifications.dart';
import 'package:biyemek/models/product_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class BusinessHomePage extends StatefulWidget {
  const BusinessHomePage({Key? key}) : super(key: key);

  @override
  State<BusinessHomePage> createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  String _businessName = "";
  String businessCity = "";
  String businessDistrict = "";
  String _businessUid = "";
  int currentStep = 0;

  //adding product page variables
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productAmountController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController normalPriceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController();

  String selectedOption = 'Meyve - Sebze';
  String selectedUnit = 'kilogram';
  DateTime? _selectedDate;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  final statuses = List.generate(
    2,
    (index) => SizedBox.square(
      dimension: 32,
      child: Center(child: Text('$index')),
    ),
  );

  int curIndex = -1;
  int lastIndex = -1;
  int _currentIndex = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchBusinessData();
  }

  Future<void> fetchBusinessData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;

        // Fetch the business name from Firestore using the UID
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('business')
            .doc(uid)
            .get();

        // Extract the business name from the document
        String name = snapshot.get('businessName');
        String city = snapshot.get('businessCity');
        String district = snapshot.get('businessDistrict');

        setState(() {
          _businessName = name;
          businessCity = city;
          businessDistrict = district;
          _businessUid = uid;
        });
      }
    } catch (e) {
      print('Error fetching UID or business name: $e');
    }
  }

  Future<void> pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {});
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //checking is user logged in
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const BusinessEntrance();
    }

    return SafeArea(
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            //main page starts here
            Container(
              color: const Color(0xFFFAFAFA),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.green,
                              size: 42,
                            ),
                            Text(
                              "${businessCity}/${businessDistrict}",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Notifications();
                                  },
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                shape: BoxShape.rectangle,
                                color: Colors.black12,
                              ),
                              padding: const EdgeInsets.all(5),
                              child: const Icon(
                                Icons.notifications,
                                color: Colors.green,
                                size: 42,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFBE7CB4),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                                shape: BoxShape.rectangle,
                                color: const Color(0xFFDBB7D6),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "${_businessName}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                  Icon(
                                    Icons.account_circle_outlined,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFBE7CB4),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFDBB7D6),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Text(
                                  "Tasarruf Edilen Para",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Image.asset(
                                  "assets/images/img_1.png",
                                  width: 48,
                                  height: 48,
                                  color: const Color(0xFFBE7CB4),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      SizedBox(width: 40),
                                      Icon(
                                        Icons.currency_lira_outlined,
                                        color: Color(0xFFBE7CB4),
                                      ),
                                      Text(
                                        "200",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFFBE7CB4)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFBE7CB4),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFDBB7D6)),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  "Önlenen",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Icon(
                                  Icons.co2_outlined,
                                  color: Color(0xFFBE7CB4),
                                  size: 50,
                                ),
                                SizedBox(width: 40),
                                Text(
                                  "33 Kg",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFFBE7CB4)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  shape: BoxShape.rectangle,
                                  color: const Color(0xFFDBB7D6)),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const Comments();
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.mode_comment_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Text(
                                      "Yorumlar",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MyProductsPage(
                                  businessUid: _businessUid,
                                );
                              },
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    shape: BoxShape.rectangle,
                                    color: const Color(0xFFDBB7D6)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.shopping_bag_outlined,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Ürünlerim",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 19,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // Sütunları yatayda hizalamak için
                          children: <Widget>[
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Container(
                                    width: 150,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xFFBE7CB4),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFDBB7D6)),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15),
                                        Text(
                                          "Bekleyen",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "Siparişler",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "0 Adet",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Expanded(
                                  child: Container(
                                    width: 150,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xFFBE7CB4),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFDBB7D6)),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15),
                                        Text(
                                          "Aktif",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "Ürünler",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        StreamBuilder<List<Product>>(
                                          stream: ProductService()
                                              .getMyProducts(_businessUid),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              int length = snapshot.data!
                                                  .length; // Here is the length
                                              return Text(
                                                '$length Adet',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22,
                                                ),
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            }
                                            return CircularProgressIndicator();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFBE7CB4),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFDBB7D6)),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15),
                                        Text(
                                          "Gönderilen",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "Siparişler",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "0 Adet",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Expanded(
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xFFBE7CB4),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xFFDBB7D6)),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 15),
                                        Text(
                                          "Teslim Edilmiş",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "Ürünler",
                                          style: TextStyle(
                                            color: Color(0xFFBE7CB4),
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "0 Adet",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), //mainpage ends here
//--------------------------------------------------------------------
            //adding product page starts here
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pink.shade100,
                            width: 2.0,
                          ),
                          color: const Color(0xFFDBB7D6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              "Ürün Oluştur",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ürün Bilgileri",
                          style: TextStyle(
                              color: Color(0xFFDBB7D6),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationThickness: 3.2),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Ürün Resmi",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    await pickImage();
                                  },
                                  child: _image != null
                                      ? Image.file(
                                          File(_image!.path),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/add_product_image.png",
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20.0,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: productNameController,
                                //user can add name of the product from here
                                decoration: InputDecoration(
                                  labelText: 'Ürün İsmi',
                                  labelStyle: TextStyle(color: Colors.green),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pinkAccent,
                                    ), // Change the outline border color when focused
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFDBB7D6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      left: 20,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Ürün Tipi",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            DropdownButton<String>(
                              //user can choose the type of product from here
                              value: selectedOption,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedOption = newValue!;
                                });
                              },
                              dropdownColor: Color(0xFFDBB7D6),
                              items: <String>[
                                'Meyve - Sebze',
                                'Şarküteri',
                                'Temel Gıda',
                                'Meze - Hazır Yemek - Donuk',
                                'Fırın - Pastane',
                                'Atıştırmalık',
                                'Meşrubat',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 15,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: productAmountController,
                                //user can add the amount of product from here
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Ürün Miktarı',
                                  labelStyle: TextStyle(
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFDBB7D6),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Row(
                              children: [
                                DropdownButton<String>(
                                  //user can specifiy the unit of the product from here
                                  value: selectedUnit,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedUnit = newValue!;
                                    });
                                  },
                                  dropdownColor: Color(0xFFDBB7D6),
                                  items: <String>[
                                    'kilogram',
                                    'adet',
                                    'litre',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Son Tüketim Tarihi",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              //user can choose the last date of the product from here
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2021),
                                  lastDate: DateTime(2025),
                                );
                                if (picked != null) {
                                  setState(() {
                                    _selectedDate = picked;
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedDate == null
                                          ? 'Tarih seçilmedi'
                                          : 'SKT : ${DateFormat.yMd().format(_selectedDate!)}',
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2021),
                                        lastDate: DateTime(2025),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          _selectedDate = picked;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15,
                      bottom: 20.0,
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: productDescriptionController,
                                decoration: InputDecoration(
                                  //user can add the description of the product from here
                                  labelText: 'Ürün Açıklaması',
                                  labelStyle: TextStyle(color: Colors.green),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFDBB7D6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: normalPriceController,
                                //user can add the normal price of the product from here
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Filter input to accept only digits
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Normal Fiyatı',
                                  labelStyle: TextStyle(
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFDBB7D6),
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: discountPriceController,
                                //user can add the discounted price of the product from here
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  labelText: 'İndirimli Fiyatı',
                                  labelStyle: TextStyle(
                                    color: Colors.green,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.pinkAccent,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFDBB7D6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Doğrulama'),
                                    content: Text(
                                        'Ürün listelemek istediğinize emin misiniz?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text(
                                          'İptal Et',
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Onayla'),
                                        onPressed: () {
                                          submitProduct();
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                            ),
                            child: Text(
                              "Onayla ve Listele",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ), //adding product page ends here
//-------------------------------------------------------------------------------------
            //profil page starts here
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext) {
                            return SizedBox(
                              height: 200,
                              child: Row(
                                children: [
                                  SizedBox(width: 70),
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.green,
                                    size: 75,
                                  ),
                                  SizedBox(width: 100),
                                  Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: Colors.green,
                                    size: 75,
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: const Icon(Icons.account_circle,
                        size: 150, color: Colors.green),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$_businessName",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Profile();
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.account_circle_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Profilimi Düzenle",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 60),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext) {
                          return Container(
                            height: 200,
                            color: Colors.white24,
                            child: Row(
                              children: [
                                SizedBox(width: 50),
                                Text(
                                  "Türkçe",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.green),
                                ),
                                SizedBox(width: 90),
                                Text(
                                  "English",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.green),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: 30),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.language,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        const Text(
                          "Dil",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 190),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: signUserOut,
                    child: Expanded(
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.green,
                            ),
                            child: const Icon(
                              Icons.exit_to_app_outlined,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            "Çıkış Yap",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          const SizedBox(width: 130),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.green,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ), //profil page ends here
          ],
        ),

        //bottom bar starts here
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Container(
            width: 130,
            height: 87,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(60.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: GNav(
                color: Colors.green,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.green,
                iconSize: 35,
                gap: 5,
                padding: const EdgeInsets.all(16),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: "Ana Sayfa",
                  ),
                  GButton(
                    icon: Icons.add_shopping_cart,
                    text: "Ürün Ekle",
                  ),
                  GButton(
                    icon: Icons.supervisor_account_rounded,
                    text: "Hesap",
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    _pageController.jumpToPage(index);
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitProduct() async {
    final uuid = const Uuid().v4();
    // Get the entered values from the text controllers
    String? downloadUrl = await uploadImage(uuid);
    String productName = productNameController.text;
    String productType = selectedOption;
    double productAmount = double.tryParse(productAmountController.text) ?? 0.0;
    String productUnit = selectedUnit;
    String productLastDate = _selectedDate != null
        ? DateFormat('dd.MM.yyyy').format(_selectedDate!)
        : '';
    String productDescription = productDescriptionController.text;
    double productNormalPrice =
        double.tryParse(normalPriceController.text) ?? 0.0;
    double productDiscountPrice =
        double.tryParse(discountPriceController.text) ?? 0.0;

    if (downloadUrl == null) {
      print("Upload image failed!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Lütfen resim yükleyiniz',
          ),
        ),
      );
      return;
    }
    // Create a Product object with the entered data
    Product product = Product(
      businessUid: _businessUid,
      id: uuid,
      businessName: _businessName,
      imageUrl: downloadUrl,
      name: productName,
      type: productType,
      amount: productAmount,
      unit: productUnit,
      lastDate: productLastDate,
      description: productDescription,
      normalPrice: productNormalPrice,
      discountPrice: productDiscountPrice,
    );

    // Store the product in Firestore
    bool isAdded = await addProductToFirestore(product, uuid);
    if (isAdded) {
      // If the product was added successfully, navigate to the SuccessPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return AddProductCompletedPage(
              productUuid: uuid,
            );
          },
        ),
      );
    } else {
      // If there was an error, show an error message.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ürünü oluştururken hata oluştu, lütfen tekrar deneyiniz.',
          ),
        ),
      );
    }
  }

  Future<bool> addProductToFirestore(Product product, String uuid) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(uuid)
          .set(product.toMap());
      return true; // return true if the product was added successfully
    } catch (e) {
      print("Error adding product to Firestore: $e");
      return false; // return false if there was an error
    }
  }

  Future<String?> uploadImage(String uuid) async {
    if (_image == null) {
      return null;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('productImages').child(uuid + '.jpg');
    UploadTask uploadTask = ref.putFile(File(_image!.path));

    // Await for the task to complete, then get the download URL
    try {
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void clearFields() {
    // Clear all text fields
    productNameController.clear();
    productAmountController.clear();
    productDescriptionController.clear();
    normalPriceController.clear();
    discountPriceController.clear();

    // Reset other variables
    _selectedDate = null;
    _image = null;
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    final startPoint = Offset(0, size.height / 2);
    final endPoint = Offset(size.width, size.height / 2);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
