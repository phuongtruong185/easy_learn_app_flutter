import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/ItemsWidgetController.dart';
import '../controllers/toggleWishListController.dart';
import '../views/itemPage/itemPage.dart';
import '../controllers/addToCartController.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({Key? key}) : super(key: key);

  @override
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  late Future<List<dynamic>> coursesFuture;

  @override
  void initState() {
    super.initState();
    coursesFuture = ItemsController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: coursesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        NumberFormat formatter = NumberFormat('#,##0', 'en_US');
        if (snapshot.hasData) {
          List<dynamic> courses = snapshot.data!;
          return
            GridView.count(
            childAspectRatio: 0.68,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              for (var course in courses)
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: (course['discount'] > 0)
                                ? Text(
                                    '-${course['discount'].toString()}%',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.put(ToggleWishListController()
                                  .toggleWishList(course, context));
                            },
                            child: Icon(
                              Icons.favorite,
                              color: (course['wishList']
                                  ? Colors.red
                                  : Colors.grey),
                              size: 27,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemPage(course: course)),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 120,
                          width: 120,
                          child: Image(
                            image: NetworkImage(course['banner']['link']),
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          course['name'],
                          style: const TextStyle(
                            color: Color(0xFF4C53A5),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        constraints: const BoxConstraints(maxHeight: 50),
                        child: Text(
                          course['description'],
                          style: const TextStyle(
                            color: Color(0xFF4C53A5),
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.clip
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RatingBar.builder(
                          initialRating: course['rate'].toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 20,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          ignoreGestures: true,
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${course['price_discount'] > 0 ? formatter.format(course['price_discount']) : formatter.format(course['price'])} VND',
                                  style: TextStyle(
                                    color: course['price_discount'] > 0
                                        ? Colors.red
                                        : const Color(0xFF4C53A5),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (course['price_discount'] > 0)
                                  Text(
                                    formatter.format(course['price']),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.put(
                                  AddToCartController()
                                      .addToCart(course, context),
                                );
                              },
                              child: const Icon(
                                Icons.shopping_cart_checkout,
                                color: Color(0xFF4C53A5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
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
