import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressDetailsPage extends StatefulWidget {
  const AddressDetailsPage({Key? key}) : super(key: key);

  @override
  _AddressDetailsPageState createState() => _AddressDetailsPageState();
}

class _AddressDetailsPageState extends State<AddressDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Adres Bilgileri'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Adres İsmi',
                ),
              ),
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(
                  labelText: 'Sokak',
                ),
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Şehir',
                ),
              ),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: 'İlçe',
                ),
              ),
              TextFormField(
                controller: _zipController,
                decoration: InputDecoration(
                  labelText: 'Posta Kodu',
                ),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  // Save address details to firestore
                  final addressDetails = {
                    'name': _nameController.text,
                    'street': _streetController.text,
                    'city': _cityController.text,
                    'state': _stateController.text,
                    'zip': _zipController.text,
                  };
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    FirebaseFirestore.instance
                        .collection('address')
                        .doc(user.uid)
                        .set(addressDetails);
                  }

                  Navigator.pop(context);
                },
                child: Text('Adresi Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
