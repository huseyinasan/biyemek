import 'package:biyemek/screens/business_screens/home/comments.dart';
import 'package:biyemek/screens/business_screens/home/location.dart';
import 'package:biyemek/screens/business_screens/home/products.dart';
import 'package:biyemek/screens/business_screens/home/profile.dart';
import 'package:biyemek/screens/onboarding/entrances/business_entrance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'add_product_completed.dart';
import 'notifications.dart';
import 'package:biyemek/models/product_model.dart';

class BusinessHomePage extends StatefulWidget {
  const BusinessHomePage({Key? key}) : super(key: key);

  @override
  State<BusinessHomePage> createState() => _BusinessHomePageState();
}

class _BusinessHomePageState extends State<BusinessHomePage> {
  String businessName = "";
  String businessCity = "";
  String businessDistrict = "";
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountedPriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int currentStep = 0;
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
          businessName = name;
          businessCity = city;
          businessDistrict = district;
        });
      }
    } catch (e) {
      print('Error fetching UID or business name: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // User is not signed in, handle this case accordingly
      return const BusinessEntrance(); // Return an empty container or another widget
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
              Container(
                color: const Color(0xFFFAFAFA),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Location();
                              },
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
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
                            const SizedBox(width: 70),
                            GestureDetector(
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
                          ],
                        ),
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
                                      "${businessName}",
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
                                  return const Products();
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
              ),
              Stepper(
                steps: getSteps(),
                type: StepperType.horizontal,
                currentStep: currentStep,
                onStepTapped: (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                onStepContinue: () {
                  if (currentStep == getSteps().length - 1) {
                    submitProduct();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductCompletedPage()),
                    );
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  if (currentStep == 0) {
                    null;
                  } else {
                    setState(() {
                      currentStep -= 1;
                    });
                  }
                },
              ),
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
                      "$businessName",
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
              )
            ]),
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

  List<Step> getSteps() => [
        Step(
            title: const Text('Ürün Bilgileri'),
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            content: Column(
              children: [
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(labelText: 'Ürün Adı'),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Normal Fiyat'),
                ),
                TextFormField(
                  controller: discountedPriceController,
                  decoration:
                      const InputDecoration(labelText: 'İndirimli Fiyat'),
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Ürün Açıklaması'),
                ),
              ],
            )),
        Step(
            title: const Text('Ürün Özellikleri'),
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Receiver Name'),
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Receiver Address'),
                ),
              ],
            )),
      ];
  void submitProduct() {
    // Get the entered values from the text controllers
    String productName = productNameController.text;
    double normalPrice = double.tryParse(priceController.text) ?? 0.0;
    double discountedPrice =
        double.tryParse(discountedPriceController.text) ?? 0.0;
    String description = descriptionController.text;

    // Create a Product object with the entered data
    Product product = Product(
      name: productName,
      price: normalPrice,
      discountedPrice: discountedPrice,
      description: description,
    );

    // Store the product in Firestore
    addProductToFirestore(product);
  }

  void addProductToFirestore(Product product) {
    FirebaseFirestore.instance.collection('products').add(product.toMap());
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
