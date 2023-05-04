import 'package:flutter/material.dart';

class AppBarCustome extends StatelessWidget {
  final String name;

  AppBarCustome({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      child: Row(
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
        ],
      ),
    );
  }
}
