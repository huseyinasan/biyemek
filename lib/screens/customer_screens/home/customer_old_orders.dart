import 'package:flutter/material.dart';

class OldOrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geçmiş Siparişler'),
        backgroundColor: Colors.pink,
      ),

      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          OrderCard(
            orderDate: '01/08/2023',
            restaurantName: 'Pizza Zone',
            orderDetails: 'Pizza, Çeşni Sos, İçecek',
            totalPrice: '40 TL',
          ),
          SizedBox(height: 16.0),
          OrderCard(
            orderDate: '28/07/2023',
            restaurantName: 'Sushi House',
            orderDetails: 'Sushi Combo, Miso Çorbası',
            totalPrice: '75 TL',
          ),
          SizedBox(height: 16.0),
          OrderCard(
            orderDate: '15/07/2023',
            restaurantName: 'Burger Express',
            orderDetails: 'Cheeseburger, Patates Kızartması, Kola',
            totalPrice: '35 TL',
          ),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderDate;
  final String restaurantName;
  final String orderDetails;
  final String totalPrice;

  const OrderCard({
    required this.orderDate,
    required this.restaurantName,
    required this.orderDetails,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sipariş Tarihi: $orderDate',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Restoran: $restaurantName'),
            SizedBox(height: 8.0),
            Text('Sipariş Detayı: $orderDetails'),
            SizedBox(height: 8.0),
            Text(
              'Toplam Tutar: $totalPrice',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geçmiş Siparişler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OldOrdersPage(),
    );
  }
}




