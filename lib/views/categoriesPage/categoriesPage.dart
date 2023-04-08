import 'package:flutter/material.dart';
import '../../widget/ItemAppBar.dart';
import '../../widget/ItemCategoriesWidget.dart';
import '../../widget/ItemsWishListWidget.dart';

class CategoriesPage extends StatelessWidget {
  final dynamic category;

  const CategoriesPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ItemAppBar(name: category['name']),
          Container(
            padding: const EdgeInsets.only(top: 15),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: Column(
              children: [
                // Items Widget
                ItemCategoriesWidget(category: category),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
