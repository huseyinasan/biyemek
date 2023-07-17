import 'package:biyemek/constants/colors.dart';
import 'package:biyemek/screens/business_screens/home/business_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../models/product_model.dart';

class AddProductCompletedPage extends StatefulWidget {
  final String productUuid;
  const AddProductCompletedPage({Key? key, required this.productUuid})
      : super(key: key);

  Future<Product> getProductData(String productUuid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(productUuid)
        .get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return Product.fromMap(data);
    } else {
      throw Exception('Böyle bir ürün yok :(');
    }
  }

  @override
  State<AddProductCompletedPage> createState() =>
      _AddProductCompletedPageState();
}

class _AddProductCompletedPageState extends State<AddProductCompletedPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Ürün Oluşturuldu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 200.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Ürün Başarıyla Oluşturuldu",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decorationThickness: 3.2),
                  ),
                ],
              ),
            ),
            //product container code will come here
            FutureBuilder<Product>(
              future: widget.getProductData(widget.productUuid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Error handling
                } else {
                  // Display the product data
                  Product product = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Material(
                      elevation: 10.0,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        color: const Color(0xFFDBB7D6),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(product.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Fiyat:  ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${product.normalPrice.toString()} ₺  ",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      ">  ${product.discountPrice.toString()} ₺",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("SKT: ${product.lastDate}"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Miktar: ${product.amount} ${product.unit}",
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const BusinessHomePage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      AppColors.figma1Color, // Set the text color to white
                ),
                child: const Text(
                  "Tamam",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
