import 'package:flutter/material.dart';

class WishListAppBar extends StatelessWidget {
  const WishListAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: const [
          Icon(
            Icons.favorite,
            size: 30,
            color: Color(0xFF4C53A5),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Danh sách yêu thích',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
