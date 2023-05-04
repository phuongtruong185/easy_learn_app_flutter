import 'package:easy_learn_app/views/myOrderPage/myCourseDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemOrderHistoryWidget extends StatelessWidget {
  const ItemOrderHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance().then((prefs) {
          String access_token = prefs.getString('access_token')!;
          access_token = access_token.replaceAll('"', '');
          return API.get('/billRecord', headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $access_token'
          });
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          NumberFormat formatter = NumberFormat('#,##0', 'en_US');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            List<dynamic> courses = snapshot?.data['data'] as List<dynamic>;
            if (courses.isNotEmpty) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (var course in courses)
                        if (course['courseId'].isNotEmpty)
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'ID: #${course['_id']}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4C53A5),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (course['courseId'].isNotEmpty)
                                        Row(
                                          children: [
                                            Image(
                                              image: NetworkImage(
                                                  course['courseId'][0]
                                                      ['banner']['link']),
                                              height: 80,
                                              width: 80,
                                            ),
                                            const SizedBox(width: 20),
                                            if (course['courseId'].length > 1)
                                              Text(
                                                '+${course['courseId'].length - 1}',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF4C53A5),
                                                ),
                                              )
                                          ],
                                        ),
                                      Row(
                                        children: [
                                          Text(
                                            '${course['price_discount'] > 0 ? formatter.format(course['price_discount']) : formatter.format(course['price'])} VND',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  course['price_discount'] > 0
                                                      ? Colors.red
                                                      : const Color(0xFF4C53A5),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          // check if product has discount is show
                                          if (course['price_discount'] > 0)
                                            Text(
                                              '${formatter.format(course['price'])} VND',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(
                                        DateTime.parse(course['createdAt'])),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              )),
                    ],
                  ));
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Image(
                    image: AssetImage('lib/assets/images/empty.png'),
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(height: 30),
                  Text('Chưa có khóa học nào',
                      style: TextStyle(
                          color: Color(0xFF4C53A5),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              );
            }
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
