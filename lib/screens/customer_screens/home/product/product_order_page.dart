import 'package:biyemek/widgets/payment_product_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../constants/colors.dart';
import '../../../../models/product_model.dart';
import '../../../../services/customer_product_service.dart';
import '../profile/customer_adress_page.dart';
import '../profile/customer_cards_page.dart';

class ProductOrderPage extends StatefulWidget {
  const ProductOrderPage({Key? key}) : super(key: key);

  @override
  _ProductOrderPageState createState() => _ProductOrderPageState();
}

class _ProductOrderPageState extends State<ProductOrderPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? cardInfo;
  Map<String, dynamic>? addressInfo;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  fetchUserDetails() async {
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> cardDoc = await FirebaseFirestore
          .instance
          .collection('card')
          .doc(user!.uid)
          .get();
      DocumentSnapshot<Map<String, dynamic>> addressDoc =
          await FirebaseFirestore.instance
              .collection('address')
              .doc(user!.uid)
              .get();

      setState(() {
        cardInfo = cardDoc.data();
        addressInfo = addressDoc.data();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Ödeme ve Sipariş",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Text(
                  "Ürünler:",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.tertiaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: CustomerProductsService().getCartProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Bir şeyler yanlış gitti'));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Sepetinizde ürün yok'));
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: PaymentProductItem(
                        product: snapshot.data![i],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDBB7D6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        FutureBuilder<double>(
                          future:
                              CustomerProductsService().getTotalNormalPrice(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Bir şeyler yanlış gitti');
                            } else {
                              return Text(
                                '${snapshot.data} ₺',
                                style: TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                  color: AppColors.secondaryColor,
                                ),
                              );
                            }
                          },
                        ),
                        FutureBuilder<double>(
                          future:
                              CustomerProductsService().getTotalDiscountPrice(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Bir şeyler yanlış gitti');
                            } else {
                              return Text(
                                ' >  ${snapshot.data} ₺',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardDetailsPage(),
                ),
              );
            },
            child: Text('Kart Bilgilerini Güncelle'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddressDetailsPage(),
                ),
              );
            },
            child: Text('Adres Bilgilerini Güncelle'),
          ),
        ],
      ),
    );
  }
}
