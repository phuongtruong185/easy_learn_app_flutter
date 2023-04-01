import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../widget/CategoriesWidget.dart';
import '../../widget/HomeAppBar.dart';
import '../../widget/ItemsWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            HomeAppBar(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                  color: Color(0xFFEDECF2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          height: 50,
                          width: 300,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Search here...',
                              hintStyle: TextStyle(
                                color: Color(0xFF4C53A5),
                                fontSize: 18,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.camera_alt,
                          size: 27,
                          color: Color(0xFF4C53A5),
                        ),
                      ],
                    ),
                  ),

                  // Categories
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: const Text('Danh Mục',
                        style: TextStyle(
                            color: Color(0xFF4C53A5),
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),

                  // Categories Widget
                  CategoriesWidget(),

                  // Items
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: const Text('Bán Chạy',
                        style: TextStyle(
                            color: Color(0xFF4C53A5),
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),

                  // Items Widget
                  ItemsWidget(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/cartPage');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/profile');
            } else {
              Navigator.pushNamed(context, '/home');
            }
          },
          backgroundColor: Colors.transparent,
          color: const Color(0xFF4C53A5),
          height: 70,
          items: const [
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ],
          animationDuration: const Duration(milliseconds: 200),
          index: 0,
        ));
  }
}
