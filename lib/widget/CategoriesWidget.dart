import 'package:flutter/material.dart';
import 'package:easy_learn_app/net/api.dart';

import '../views/categoriesPage/categoriesPage.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: API.get('/categoryCourse'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<dynamic> categories = snapshot?.data['data'] as List<dynamic>;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (var category in categories)
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoriesPage(category: category)),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // click to category

                          children: [
                            Image(
                              image: NetworkImage(category['banner']['link']),
                              height: 60,
                              width: 60,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              category['name'],
                              style: const TextStyle(
                                color: Color(0xFF4C53A5),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      )),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
