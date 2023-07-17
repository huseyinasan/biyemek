import 'package:biyemek/screens/customer_screens/home/product/order_sucess_page.dart';
import 'package:biyemek/widgets/payment_product_item.dart';
import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../models/product_model.dart';
import '../../../../services/customer_info_service.dart';
import '../../../../services/customer_product_service.dart';
import '../profile/customer_adress_page.dart';
import '../profile/customer_cards_page.dart';

class ProductOrderPage extends StatefulWidget {
  const ProductOrderPage({Key? key}) : super(key: key);

  @override
  _ProductOrderPageState createState() => _ProductOrderPageState();
}

class _ProductOrderPageState extends State<ProductOrderPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData() async {
    CustomerInfoService().getCardName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.figma1Color,
        title: const Text(
          "Ödeme ve Sipariş",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Text(
                  "Ürünler:",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.figma3Color,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: CustomerProductsService().getCartProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Bir şeyler yanlış gitti'));
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Sepetinizde ürün yok'));
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, i) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: PaymentProductItem(
                        product: snapshot.data![i],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: AppColors.tertiaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String?>(
                    future: CustomerInfoService().getCardName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Bir şeyler yanlış gitti');
                      } else if (snapshot.data == null) {
                        return const Text(
                            'Seçili kart yok, lütfen kart giriniz.');
                      } else {
                        return Text(
                          'Seçili Kart : ${snapshot.data}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.figma1Color,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CardDetailsPage(),
                        ),
                      );
                      setState(() {});
                    },
                    child: const Text('Kartı Güncelle'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: AppColors.tertiaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder<String?>(
                    future: CustomerInfoService().getAdressName(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return const Text('Bir şeyler yanlış gitti');
                      } else if (snapshot.data == null) {
                        return const Text(
                            'Seçili adres yok, lütfen adres giriniz.');
                      } else {
                        return Text(
                          'Seçili Adres : ${snapshot.data}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.figma1Color,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddressDetailsPage(),
                        ),
                      );
                      setState(() {});
                    },
                    child: const Text('Adresi Güncelle'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFDBB7D6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        FutureBuilder<double>(
                          future:
                              CustomerProductsService().getTotalNormalPrice(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Bir şeyler yanlış gitti');
                            } else {
                              return Text(
                                '${snapshot.data} ₺',
                                style: const TextStyle(
                                  fontSize: 14,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black,
                                ),
                              );
                            }
                          },
                        ),
                        FutureBuilder<double>(
                          future:
                              CustomerProductsService().getTotalDiscountPrice(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text('Bir şeyler yanlış gitti');
                            } else {
                              return Text(
                                ' >  ${snapshot.data} ₺',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.figma1Color,
                      ),
                      onPressed: () async {
                        try {
                          await CustomerProductsService().orderProduct();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const OrderSucessPage();
                              },
                            ),
                          );
                        } catch (e) {
                          // Show snackbar with the error message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Bir hata oluştu. Lütfen tekrar deneyin.'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Siparişi Tamamla",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
