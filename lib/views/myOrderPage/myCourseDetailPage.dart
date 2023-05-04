import 'package:flutter/material.dart';

import '../../widget/ItemAppBar.dart';
import '../../widget/ItemMyOrderDetailWidget.dart';

class MyCourseDetailPage extends StatelessWidget {
  final dynamic course;

  const MyCourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // border radius only for top side
      body: ListView(
        children: [
          ItemAppBar(name: course['name']),
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
                ItemMyOrderDetailWidget(courseId: course['_id']),

                // Items Widget
              ],
            ),
          ),
          // list ExpansionTile
        ],
      ),
    );
  }
}
