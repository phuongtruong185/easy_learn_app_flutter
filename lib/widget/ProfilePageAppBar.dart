import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class ProfilePageAppBar extends StatelessWidget {
  const ProfilePageAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: const [
          Icon(
            Icons.person,
            size: 30,
            color: Color(0xFF4C53A5),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text('Thông Tin Cá Nhân',
                  style: TextStyle(
                      color: Color(0xFF4C53A5),
                      fontSize: 23,
                      fontWeight: FontWeight.bold))),
          Spacer(),
        ],
      ),
    );
  }
}
