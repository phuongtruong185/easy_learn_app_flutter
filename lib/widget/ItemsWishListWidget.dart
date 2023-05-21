import 'package:flutter/material.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/toggleWishListController.dart';
import '../controllers/wishListController.dart';
import '../views/itemPage/itemPage.dart';
import '../controllers/addToCartController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemWishListWidget extends StatelessWidget {
  final wishListController = Get.put(WishListController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: wishListController.wishList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          NumberFormat formatter = NumberFormat('#,##0', 'en_US');
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(() {
                  if (wishListController.wishListItem.isNotEmpty) {
                    return GridView.count(
                      childAspectRatio: 0.68,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: [
                        for (var course in wishListController.wishListItem)
                          Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                  fontWeight: FontWeight.bold))
                                          : null,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.put(ToggleWishListController()
                                            .toggleWishList(course, context));
                                      },
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
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
                                          builder: (context) =>
                                              ItemPage(course: course)),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 120,
                                    width: 120,
                                    child: Image(
                                      image: NetworkImage(
                                          course['banner']['link']),
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
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  constraints:
                                      const BoxConstraints(maxHeight: 50),
                                  child: Text(
                                    course['description'],
                                    style: const TextStyle(
                                        color: Color(0xFF4C53A5), fontSize: 15),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              '${course['price_discount'] > 0 ? formatter.format(course['price_discount']) : formatter.format(course['price'])} VND',
                                              style: TextStyle(
                                                  color:
                                                      course['price_discount'] >
                                                              0
                                                          ? Colors.red
                                                          : const Color(
                                                              0xFF4C53A5),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(width: 10),
                                          if (course['price_discount'] > 0)
                                            Text(
                                              formatter.format(course['price']),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.put(AddToCartController()
                                              .addToCart(course, context));
                                        },
                                        child: const Icon(
                                          Icons.shopping_cart_checkout,
                                          color: Color(0xFF4C53A5),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // height full screen
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Image(
                          image: AssetImage('lib/assets/images/empty.png'),
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(height: 30),
                        Text('Không có khóa học yêu thích',
                            style: TextStyle(
                                color: Color(0xFF4C53A5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold))
                      ],
                    );
                  }
                }));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  List jsonMapToList(data) {
    List list = [];
    for (var item in data) {
      list.add(item);
    }
    return list;
  }
}
