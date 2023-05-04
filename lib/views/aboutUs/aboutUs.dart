import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../widget/AppBarCustome.dart';
import '../../widget/ItemOrderHistoryWidget.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            AppBarCustome(name: 'Giới Thiệu'),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // background color is white
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      // rounded
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.group,
                            size: 24,
                            color: Color(0xFF4C53A5),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Nhóm 10',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        // background color is white
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 20),
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        // rounded
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 24,
                              color: Color(0xFF4C53A5),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Trương Ngọc Phương',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4C53A5),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Trần Lưu Thế Anh',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4C53A5),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        // background color is white
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 20),
                        margin: const EdgeInsets.only(left: 16, right: 16),
                        // rounded
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.info_outline,
                              size: 24,
                              color: Color(0xFF4C53A5),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                'Easy Learn là một ứng dụng giáo dục trực tuyến, cung cấp các khóa học trực tuyến cho người dùng. Với Easy Learn, bạn có thể học bất kỳ kỹ năng hoặc chủ đề nào mà bạn quan tâm, từ lập trình, tiếng Anh, marketing đến nấu ăn và yoga. Các khóa học trên Easy Learn được thiết kế để giúp người học tăng cường kỹ năng và kiến thức của mình một cách dễ dàng và hiệu quả. Ứng dụng cung cấp nhiều lựa chọn khóa học với các mức giá khác nhau để phù hợp với nhu cầu và túi tiền của từng người dùng.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4C53A5),
                                ),
                                textAlign: TextAlign.justify,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // background color is white
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      // rounded
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.verified_outlined,
                            size: 24,
                            color: Color(0xFF4C53A5),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            '1.1.1',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C53A5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/myOrder');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/wishList');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            } else {
              Navigator.pushNamed(context, '/home');
            }
          },
          backgroundColor: Colors.transparent,
          color: const Color(0xFF4C53A5),
          height: 70,
          items: const [
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.book_outlined,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.favorite,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ],
          animationDuration: const Duration(milliseconds: 200),
          index: 3,
        ));
  }
}
