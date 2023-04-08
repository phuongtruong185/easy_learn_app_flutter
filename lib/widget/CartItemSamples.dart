import 'package:flutter/material.dart';
import '../controllers/cartController.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../controllers/deleteItemCartController.dart';

class CartItemSamples extends StatelessWidget {
  final cartController = Get.put(CartController()); // Khởi tạo controller

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: cartController.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          NumberFormat formatter = NumberFormat('#,##0', 'en_US');
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(() {
                  if (cartController.products.isNotEmpty) {
                    return Column(
                      children: [
                        for (var product in cartController.products)
                          Container(
                            height: 110,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  margin: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          product['banner']['link']),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        product['name'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4C53A5),
                                        ),
                                      ),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                '${product['price_discount'] > 0 ? formatter.format(product['price_discount']) : formatter.format(product['price'])} VND',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: product[
                                                              'price_discount'] >
                                                          0
                                                      ? Colors.red
                                                      : const Color(0xFF4C53A5),
                                                )),
                                            const SizedBox(width: 10),
                                            // check if product has discount is show
                                            if (product['price_discount'] > 0)
                                              Text(
                                                '${formatter.format(product['price'])} VND',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                          ])
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.put(DeleteItemCartController()
                                              .deleteItemCart(
                                                  product, context));
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 27,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // height full screen
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Image(
                          image: AssetImage('lib/assets/images/empty.png'),
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(height: 30),
                        Text('Giỏ hàng trống',
                            style: TextStyle(
                                color: Color(0xFF4C53A5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ],
                    );
                  }
                }));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
