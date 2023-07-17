import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class OldOrdersPage extends StatelessWidget {
  const OldOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geçmiş Siparişler'),
        backgroundColor: AppColors.figma1Color,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Geçmiş Sipariş Bulunmamaktadır.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
