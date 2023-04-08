import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import '../controllers/cartController.dart';

class ItemAppBar extends StatelessWidget {
  final String name;

  ItemAppBar({Key? key, required this.name}) : super(key: key);
  final cartController = Get.put(CartController()); // Khởi tạo controller

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cartController.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
              color: Colors.white,
              padding: EdgeInsets.all(25),
              child: Obx(() {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios,
                          color: Color(0xFF4C53A5), size: 30),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(name,
                            style: const TextStyle(
                                color: Color(0xFF4C53A5),
                                fontSize: 23,
                                fontWeight: FontWeight.bold))),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.favorite, color: Colors.red, size: 30),
                        const SizedBox(width: 20),
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
                    )
                  ],
                );
              }));
        });
  }
}
