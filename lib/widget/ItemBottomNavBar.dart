import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBottomNavBar extends StatelessWidget {
  const ItemBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Text(
              '\$120',
              style: TextStyle(
                  color: Color(0xFF4C53A5),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {},
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
