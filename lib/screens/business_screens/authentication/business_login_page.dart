import 'package:biyemek/components/back_button.dart';
import 'package:biyemek/screens/business_screens/authentication/business_register_page.dart';
import 'package:biyemek/screens/business_screens/home/business_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/my_button.dart';
import '../../../components/my_textfield.dart';

class BusinessLoginPage extends StatefulWidget {
  const BusinessLoginPage({super.key});

  @override
  State<BusinessLoginPage> createState() => _BusinessLoginPageState();
}

class _BusinessLoginPageState extends State<BusinessLoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // sign user in method
  Future<void> signUserIn(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        final businessRef = FirebaseFirestore.instance.collection('business');
        final businessDoc = await businessRef.doc(user.uid).get();

        if (businessDoc.exists) {
          //Navigating to customer home page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const BusinessHomePage();
              },
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hesap bir işletme hesabı değildir.'),
            ),
          );
        }
      }
    } catch (e) {
      print('Error signing in: $e');

      String errorMessage = 'Bir hata meydana geldi. Lütfen tekrar deneyin.';

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          errorMessage = 'Kullanıcı adı veya şifre hatalı.';
        }
      }

      // Show snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackToButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                // logo
                Image.asset(
                  "assets/images/logo/logo.png",
                  width: 150,
                  height: 150,
                ),
                Text(
                  'Ürünlerini Listele, İsrafı Önle!',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  obscureText: false,
                ),
                //asdfasdfsadfasdfasdfa

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Şifre',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Şifremi Unuttum',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  onTap: () {
                    signUserIn(context);
                  },
                ),
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.orange,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'veya',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // google button
                      SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
                // not a member? register now
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'İşletmeniz Kayıtlı Değil mi?',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const BusinessRegisterPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Şimdi Kayıt Olun',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
