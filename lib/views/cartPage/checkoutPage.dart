import 'package:easy_learn_app/widget/CheckoutItem.dart';
import 'package:flutter/material.dart';

import '../../widget/CartAppBar.dart';
import '../../widget/CartBottomNavBar.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const CartAppBar(title: "Thanh toán"),
          Container(
              height: 700,
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  CheckoutItem(),
                ],
              )),
        ],
      ),
      bottomNavigationBar: CartBottomNavBar(checkout: true),
    );
  }
}
