import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widget/ItemAppBar.dart';
import '../../widget/ItemBottomNavBar.dart';

class ItemPage extends StatelessWidget {
  final dynamic course;

  const ItemPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffedecf2),
        body: ListView(
          children: [
            ItemAppBar(name: course['name']),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.network(
                course['banner']['link'],
                height: 400,
                fit: BoxFit.contain,
              ),
            ),
            Arc(
              edge: Edge.TOP,
              arcType: ArcType.CONVEY,
              height: 30,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50, bottom: 15),
                          child: Row(
                            children: [
                              Text(course['name'],
                                  style: const TextStyle(
                                      color: Color(0xFF4C53A5),
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar.builder(
                                initialRating: course['rating']['average'],
                                minRating: 1,
                                direction: Axis.horizontal,
                                itemCount: 5,
                                itemSize: 20,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.favorite,
                                  color: Colors.yellow,
                                ),
                                ignoreGestures: true,
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              course['description'],
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                color: Color(0xFF4C53A5),
                                fontSize: 17,
                              ),
                            )),

                      ],
                    )),
              ),
            )
          ],
        ),
      bottomNavigationBar: ItemBottomNavBar(course: course),
    );
  }
}
