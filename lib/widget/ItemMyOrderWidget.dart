import 'package:easy_learn_app/views/myOrderPage/myCourseDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemMyOrderWidget extends StatelessWidget {
  const ItemMyOrderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance().then((prefs) {
          String access_token = prefs.getString('access_token')!;
          access_token = access_token.replaceAll('"', '');
          return API.get('/course/buy', headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $access_token'
          });
        }),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<dynamic> courses = snapshot?.data['data'] as List<dynamic>;
            if (courses.isNotEmpty) {
              return GridView.count(
                childAspectRatio: 0.85,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                children: [
                  for (var course in courses)
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MyCourseDetailPage(course: course)),
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
                              child: Text(course['name'],
                                  style: const TextStyle(
                                      color: Color(0xFF4C53A5),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(maxHeight: 50),
                            child: Text(course['description'],
                                style: const TextStyle(
                                    color: Color(0xFF4C53A5), fontSize: 15),
                              overflow: TextOverflow.clip,
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
