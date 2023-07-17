import 'dart:async';

import 'package:biyemek/components/category_name.dart';
import 'package:biyemek/constants/colors.dart';
import 'package:biyemek/screens/customer_screens/home/product/product_detail_order_page.dart';
import 'package:biyemek/screens/customer_screens/home/product/product_order_page.dart';
import 'package:biyemek/screens/customer_screens/home/profile/customer_profile_page.dart';
import 'package:biyemek/screens/onboarding/entrances/customer_entrance.dart';
import 'package:biyemek/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../models/product_model.dart';
import '../../../services/customer_product_service.dart';
import '../../../widgets/cart_products_item.dart';
import '../../../widgets/my_orders_item.dart';
import '../../../widgets/product_grid_view.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  late Stream<List<Product>> _cartProductsStream;
  late StreamSubscription<List<Product>> _cartProductsStreamSubscription;

  int currentStep = 0;
  final statuses = List.generate(
    2,
    (index) => SizedBox.square(
      dimension: 32,
      child: Center(child: Text('$index')),
    ),
  );

  int curIndex = -1;
  int lastIndex = -1;
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _cartProductsStream = CustomerProductsService().getCartProducts();
    _cartProductsStreamSubscription = _cartProductsStream.listen((_) {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cartProductsStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const CustomerEntrance();
    }

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
        appBar: CustomAppBar(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const CustomerProfilePage();
                },
              ),
            );
          },
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            Padding(
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
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.figma3Color,
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
                          ProductGridView(
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
//my cart page starts here-------------------------------------------------
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Sepetinizdeki Ürünler",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.figma3Color,
                    decoration: TextDecoration.underline,
                  ),
                ),
                //products will come here
                Expanded(
                  child: StreamBuilder<List<Product>>(
                    stream: CustomerProductsService().getCartProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Bir şeyler yanlış gitti'));
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Sepetinizde ürün yok'));
                      } else {
                        return ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: CartProductItem(
                              product: snapshot.data![i],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Fiyat:  ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              FutureBuilder<double>(
                                future: CustomerProductsService()
                                    .getTotalNormalPrice(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                        'Bir şeyler yanlış gitti');
                                  } else {
                                    return Text(
                                      '${snapshot.data} ₺',
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    );
                                  }
                                },
                              ),
                              FutureBuilder<double>(
                                future: CustomerProductsService()
                                    .getTotalDiscountPrice(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                        'Bir şeyler yanlış gitti');
                                  } else {
                                    return Text(
                                      ' >  ${snapshot.data} ₺',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ProductOrderPage();
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: AppColors.figma1Color,
                            ),
                            child: const Text(
                              "Devam Et",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ), //my cart page ends here-------------------------------------------------
//my order page starts here-------------------------------------------------------------
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Siparişlerim",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.figma3Color,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: StreamBuilder<List<Product>>(
                    stream: CustomerProductsService().getOrderProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(
                            child: Text('Bir şeyler yanlış gitti'));
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('Aktif siparişiniz yok'));
                      } else {
                        return ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (ctx, i) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ProductDetailsOrderPage(
                                      product: snapshot.data![i]),
                                ));
                              },
                              child: OrderItem(
                                product: snapshot.data![i],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
//my order page ends here-------------------------------------------------------------
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Container(
            width: 130,
            height: 87,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.figma1Color,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(60.0),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: GNav(
                color: AppColors.figma1Color,
                activeColor: Colors.white,
                tabBackgroundColor: AppColors.figma1Color,
                iconSize: 35,
                gap: 5,
                padding: const EdgeInsets.all(16),
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: "Ana Sayfa",
                  ),
                  GButton(
                    icon: Icons.shopping_basket,
                    text: "Sepetim",
                  ),
                  GButton(
                    icon: Icons.food_bank_outlined,
                    text: "Siparişlerim",
                  ),
                ],
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() {
                    _pageController.jumpToPage(index);
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
