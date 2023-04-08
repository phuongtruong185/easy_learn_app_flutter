import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import '../controllers/cartController.dart';

class HomeAppBar extends StatelessWidget {
  final cartController = Get.put(CartController()); // Khởi tạo controller

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cartController.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
              color: Colors.white,
              padding: const EdgeInsets.all(25),
              child: Obx(() {
                return Row(
                  children: [
                    const Icon(
                      Icons.sort,
                      size: 30,
                      color: Color(0xFF4C53A5),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('Easy Learn',
                            style: TextStyle(
                                color: Color(0xFF4C53A5),
                                fontSize: 23,
                                fontWeight: FontWeight.bold))),
                    const Spacer(),
                    badges.Badge(
                      badgeStyle: const badges.BadgeStyle(
                        badgeColor: Colors.red,
                        padding: EdgeInsets.all(7),
                      ),
                      badgeContent: Text(
                        cartController.quantityOrdered.value.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/cartPage');
                        },
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 32,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                    )
                  ],
                );
              }));
        });
  }
}
