import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../widget/ItemMyOrderWidget.dart';
import '../../widget/MyOrderAppBar.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            const MyOrderAppBar(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  color: Color(0xFFEDECF2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              child: Column(
                children: const [
                  // Items Widget
                  ItemMyOrderWidget(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/myOrder');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/wishList');
            } else if (index == 3) {
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
              Icons.book_outlined,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.favorite,
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
          index: 1,
        ));
  }
}
