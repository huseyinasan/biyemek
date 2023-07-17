import 'package:biyemek/screens/customer_screens/home/customer_homepage.dart';
import 'package:flutter/material.dart';

class OrderSucessPage extends StatefulWidget {
  const OrderSucessPage({Key? key}) : super(key: key);

  @override
  State<OrderSucessPage> createState() => _OrderSucessPage();
}

class _OrderSucessPage extends State<OrderSucessPage> {
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
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          "Sipariş Başarılı",
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
            const Padding(
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
                    "Siparişiniz İşletmeye İletildi",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decorationThickness: 3.2),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Siparişlerim Sekmesinden Takip Edebilirsiniz",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const CustomerHomePage();
                    },
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "Tamam",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
