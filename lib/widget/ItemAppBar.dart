import 'package:flutter/material.dart';

class ItemAppBar extends StatelessWidget {
  final String name;
  const ItemAppBar({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF4C53A5),
                  size: 30
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(name,
                    style: TextStyle(
                        color: Color(0xFF4C53A5),
                        fontSize: 23,
                        fontWeight: FontWeight.bold))
            ),
            const Spacer(),
            Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30
            )
          ],
        ));
  }
}
