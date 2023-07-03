import 'package:biyemek/screens/onboarding/entrance.dart';
import 'package:biyemek/screens/register/register_page.dart';
import 'package:flutter/material.dart';


class Choose_register extends StatefulWidget {
  const Choose_register({Key? key}) : super(key: key);

  @override
  State<Choose_register> createState() => _Choose_registerState();
}

class _Choose_registerState extends State<Choose_register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              // İşletme girişi için seçenek
              margin: const EdgeInsets.only(bottom: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Entrance(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/business_icon.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'İşletme Girişi',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // Müşteri girişi için seçenek
              margin: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustomerLoginScreen(),
                    ),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/customer_icon.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Müşteri Girişi',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
class BusinessLoginScreen extends StatelessWidget {
  const BusinessLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İşletme Girişi'),
      ),
      body: Center(
        child: Text(
          'İşletme Girişi Sayfası',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CustomerLoginScreen extends StatelessWidget {
  const CustomerLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteri Girişi'),
      ),
      body: Center(
        child: Text(
          'Müşteri Girişi Sayfası',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}