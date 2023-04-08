import 'package:flutter/material.dart';
import '../../widget/ItemAppBar.dart';
import '../../widget/ItemSearchWidget.dart';

class SearchPage extends StatelessWidget {
  final dynamic course;

  const SearchPage({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ItemAppBar(name: course),
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
                ItemSearchWidget(course: course),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
