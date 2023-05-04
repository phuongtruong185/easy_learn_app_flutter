import 'package:flutter/material.dart';
import '../controllers/cartController.dart';
import '../controllers/checkoutController.dart';
import '../net/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class CartBottomNavBar extends StatelessWidget {
  final cartController = Get.put(CartController());
  final checkoutController = Get.put(CheckoutController());
  final bool checkout;

  CartBottomNavBar({super.key, required this.checkout});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cartController.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            NumberFormat formatter = NumberFormat('#,##0', 'en_US');
            return BottomAppBar(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  height: 170,
                  child: Obx(() {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tổng Tiền:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "${formatter.format(cartController.total.value).toString()} VND",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Giảm Giá:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "${formatter.format(cartController.total.value - cartController.priceDiscount.value).toString()} VND",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Thanh Toán:",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4C53A5),
                              ),
                            ),
                            Text(
                              "${formatter.format(cartController.priceDiscount.value).toString()} VND",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4C53A5),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (checkout) {
                              checkoutController.checkout(cartController.cartId.value, context); // Thực hiện hàm checkout với đối số tương ứng
                            } else {
                              Navigator.pushNamed(context, '/checkout');
                            }
                          },
                          child: Container(
                            height: 50,
                            // click to /checkout
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4C53A5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Thanh Toán",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  })),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  List jsonMapToList(data) {
    List list = [];
    for (var item in data) {
      list.add(item);
    }
    return list;
  }
}
