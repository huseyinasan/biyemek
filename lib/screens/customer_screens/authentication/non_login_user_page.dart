import 'package:biyemek/components/category_name.dart';
import 'package:biyemek/constants/colors.dart';
import 'package:biyemek/screens/customer_screens/authentication/customer_register_page.dart';
import 'package:flutter/material.dart';
import '../../../widgets/non_login_product_grid.dart';

class NonLoginUserPage extends StatefulWidget {
  const NonLoginUserPage({Key? key}) : super(key: key);

  @override
  State<NonLoginUserPage> createState() => _NonLoginUserPageState();
}

class _NonLoginUserPageState extends State<NonLoginUserPage> {
  final statuses = List.generate(
    2,
    (index) => SizedBox.square(
      dimension: 32,
      child: Center(child: Text('$index')),
    ),
  );

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'Meyve - Sebze',
      'Şarküteri',
      'Temel Gıda',
      'Meze - Hazır Yemek - Donuk',
      'Fırın - Pastane',
      'Atıştırmalık',
      'Meşrubat',
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Stack(
            children: [
              const Text(
                "Bi'Yemek",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const CustomerRegisterPage();
                          },
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.person_2_rounded,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Yakınımdaki Ürünler",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.tertiaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ...List.generate(categories.length, (index) {
                  return Column(
                    children: [
                      CategoryName(
                        text: categories[index], //category name
                      ),
                      NonLoginProductGridView(
                          category: categories[index]), //product
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ), //homepage ends here------------------------------------
      ),
    );
  }
}
