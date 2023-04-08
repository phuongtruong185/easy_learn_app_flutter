import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/addToCartController.dart';

class ItemBottomNavBar extends StatelessWidget {
  final dynamic course;

  const ItemBottomNavBar({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat('#,##0', 'en_US');
    return BottomAppBar(
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                    '${course['price_discount'] > 0 ? formatter.format(course['price_discount']) : formatter.format(course['price'])} VND',
                    style: TextStyle(
                        color: course['price_discount'] > 0
                            ? Colors.red
                            : const Color(0xFF4C53A5),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                if (course['price_discount'] > 0)
                  Text(
                    formatter.format(course['price']),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            ElevatedButton.icon(
              onPressed: () {
                Get.put(AddToCartController()
                    .addToCart(course, context));
              },
              icon: const Icon(
                CupertinoIcons.cart_badge_plus,
              ),
              label: const Text('Thêm vào giỏ hàng',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style:ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4C53A5)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
