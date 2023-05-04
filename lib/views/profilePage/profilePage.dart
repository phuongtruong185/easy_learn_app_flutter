import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../widget/ProfilePageAppBar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            const ProfilePageAppBar(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                  color: Color(0xFFEDECF2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/changePass');
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: const Size(double.infinity, 40),
                            primary: Colors.white,
                            shadowColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.key_sharp,
                                color: Color(0xFF4C53A5),
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text('Đổi mật khẩu',
                                  style: TextStyle(
                                      color: Color(0xFF4C53A5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ))),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/orderHistory');
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: const Size(double.infinity, 40),
                            primary: Colors.white,
                            shadowColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.history,
                                color: Color(0xFF4C53A5),
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text('Lịch Sử Mua Hàng',
                                  style: TextStyle(
                                      color: Color(0xFF4C53A5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ))),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/contactUs');
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: const Size(double.infinity, 40),
                            primary: Colors.white,
                            //set box shadow is none
                            shadowColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.phone,
                                color: Color(0xFF4C53A5),
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text('Hỗ trợ khách hàng',
                                  style: TextStyle(
                                      color: Color(0xFF4C53A5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ))),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/aboutUs');
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: const Size(double.infinity, 40),
                            primary: Colors.white,
                            shadowColor: Colors.transparent,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.info_outline,
                                color: Color(0xFF4C53A5),
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text('Giới Thiệu',
                                  style: TextStyle(
                                      color: Color(0xFF4C53A5),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ))),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 20),
                      margin: const EdgeInsets.only(left: 16, right: 16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ElevatedButton(
                          onPressed: () {
                            SharedPreferences.getInstance().then((prefs) {
                              prefs.remove('access_token');
                              var snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Success!',
                                  message: 'Đăng xuất thành công',
                                  contentType: ContentType.success,
                                  inMaterialBanner: true,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pushNamed(context, '/sign-in');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            minimumSize: const Size(double.infinity, 40),
                            primary: Colors.white,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: 30,
                          )))
                ],
              ),
            ),
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
