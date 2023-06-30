import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:biyemek/screens/login/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? passwordErrorText;
  String? confirmPasswordErrorText;

  Future<void> registerUser(BuildContext context) async {
    try {
      String email = emailController.text;
      String password = passwordController.text;
      String name = nameController.text;
      String surname = surnameController.text;
      int phone = int.parse(phoneController.text);

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Additional user registration logic goes here

      // Get the newly created user's UID
      String uid = userCredential.user!.uid;

      // Store the user's name in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'surname': surname,
        'phone': phone,
      });

      String succesName = nameController.text;

      // Clear form fields after successful registration
      nameController.clear();
      surnameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

      // Show a success dialog or navigate to the desired screen
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Üyelik Başarılı'),
            content: Text("Tebrikler Başarıyla üye oldun ${succesName} !"),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ),
                  );
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error registering user: $e');

      String errorMessage = 'Bir hata oluştu lütfen tekrar deneyin.';

      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          errorMessage = 'E-mail zaten kullanımda.';
        } else if (e.code == 'weak-password') {
          errorMessage = 'Şifre çok zayıf.';
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

  void validatePasswords() {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        passwordErrorText = 'Şifre alanı boş olamaz.';
        confirmPasswordErrorText = 'Şifre alanı boş olamaz.';
      });
    } else if (password != confirmPassword) {
      setState(() {
        passwordErrorText = 'Şifreler uyuşmuyor.';
        confirmPasswordErrorText = 'Şifreler uyuşmuyor.';
      });
    } else {
      setState(() {
        passwordErrorText = null;
        confirmPasswordErrorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: BackButton(),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    'Aramıza katılmadan önce seni tanıyalım.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  labelText: "Ad",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: surnameController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  labelText: "Soyad",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  labelText: "E-Mail",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  labelText: "Telefon Numarası (53xxx....)",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  labelText: "Şifre",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  errorText: passwordErrorText,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  labelText: "Şifreyi Doğrula",
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  errorText: confirmPasswordErrorText,
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  validatePasswords(); // Validate the password fields
                  if (passwordErrorText == null &&
                      confirmPasswordErrorText == null) {
                    registerUser(
                        context); // Proceed with the registration if passwords are valid
                  }
                },
                child: const Text(
                  'ÜYE OL',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(
                color: Color(0xFFE2F3EE),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'İşletme misiniz?',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const RegisterPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Buradan devam edin!',
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
    );
  }
}
