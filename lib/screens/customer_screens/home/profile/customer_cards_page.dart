import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../constants/colors.dart';

class CardDetailsPage extends StatefulWidget {
  const CardDetailsPage({Key? key}) : super(key: key);

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryMonthController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _expiryYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.figma1Color,
        title: const Text('Kart Bilgileri'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _cardNameController,
                decoration: const InputDecoration(
                  labelText: 'Kart İsmi',
                ),
              ),
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Kart Nu.',
                ),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _expiryMonthController,
                      decoration: const InputDecoration(
                        labelText: 'Ay',
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _expiryYearController,
                      decoration: const InputDecoration(
                        labelText: 'Yıl',
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.figma1Color,
                ),
                onPressed: () {
                  // Save card details to firestore
                  final cardDetails = {
                    'cardname': _cardNameController.text,
                    'cardNumber': _cardNumberController.text,
                    'expiryYear': _expiryYearController.text,
                    'expiryMonth': _expiryMonthController.text,
                    'cvv': _cvvController.text,
                  };
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    FirebaseFirestore.instance
                        .collection('card')
                        .doc(user.uid)
                        .set(cardDetails);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Kartı Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
