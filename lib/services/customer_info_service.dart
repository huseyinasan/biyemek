import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerInfoService {
  final _cardRef = FirebaseFirestore.instance.collection('card');
  final _adressRef = FirebaseFirestore.instance.collection('address');

  Future<String?> getCardName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final cardDoc = await _cardRef.doc(user.uid).get();
      if (cardDoc.exists) {
        return cardDoc.data()?['cardname'];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<String?> getAdressName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final adressDoc = await _adressRef.doc(user.uid).get();
      if (adressDoc.exists) {
        return adressDoc.data()?['name'];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
