import 'package:flutter/material.dart';

class CustomerProfileInfo extends StatelessWidget {
  const CustomerProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bilgilerim'),
      ),
      body: const Center(
        child: Text('Bilgilerim Sayfası'),
      ),
    );
  }
}
